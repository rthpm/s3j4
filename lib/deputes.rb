# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

BASE_URL = 'https://www2.assemblee-nationale.fr'
PAGE = Nokogiri::HTML(URI.open("#{BASE_URL}/deputes/liste/alphabetique"))

def page_query
  BASE_URL.class
end

def query_depute_email(depute_url)
  email = Nokogiri::HTML(URI.open("#{BASE_URL}#{depute_url}"))
  email.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
end

def query_depute
  depute_table = []
  PAGE.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |depute_anchor|
    url = depute_anchor.xpath('./@href').text
    depute_name = depute_anchor.text.sub('M. ', '').sub('Mme ', '').split(' ').slice(0) # Sélection du premier mot après M./Mme
    depute_last_name = depute_anchor.text.sub('M. ', '').sub('Mme ', '').split(' ').slice(1..3) # Sélection du reste (on suppose que c'est le nom de famille
    email = query_depute_email(url)
    printf '.' # Pour patienter
    depute_table << {
      'first_name' => depute_name,
      'last_name' => depute_last_name,
      'email' => email
    }
  end
  pp depute_table
  depute_table
end

def deputes_count(number_of_deputes)
  total = query_depute
  true if total.count > number_of_deputes
end

def major_deputes(depute_name)
  depute_array = query_deputes
  depute_array.select { |k| k[depute_name] }.empty?
end

query_depute
