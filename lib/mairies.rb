# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

BASE_URL = 'https://www.annuaire-des-mairies.com/'
PAGE = Nokogiri::HTML(URI.open("#{BASE_URL}/val-d-oise.html"))

def page_query
  BASE_URL.class
end

def query_townhall_email(townhall_url)
  email = Nokogiri::HTML(URI.open("#{BASE_URL}#{townhall_url}"))
  email.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').text
end

def query_townhall
  townhall_table = []
  PAGE.xpath('//a[@class="lientxt"]').each do |town_name|
    url = town_name.xpath('./@href').text
    # On efface le contenu du hash si l'email n'est pas renseigné
    townhall_table << Hash[town_name.text, query_townhall_email(url)].delete_if { |_k, v| v.empty? }
    printf '.' # Pour patienter
  rescue StandardError => e
  end
  townhall_table.delete_if(&:empty?) # On efface les hash vides
end

def townhall_count(number_of_towns)
  total = query_townhall
  true if total.count > number_of_towns
end

def major_town(town_name)
  town_array = query_townhall
  town_array.select { |k| k[town_name] }.empty?
end

# query_townhall
