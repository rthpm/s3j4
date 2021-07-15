# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

PAGE = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

def page_query
  PAGE.class
end

def crypto_query
  crypto_table = []
  PAGE.xpath('/html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr').each do |tr|
    crypto_table << Hash[tr.xpath('./td[3]/div').text, tr.xpath('./td[5]/div/a').text].delete_if { |k, _v| k.empty? }
  end
  crypto_table.delete_if(&:empty?)
end

def crypto_count(number_of_results)
  total = crypto_query
  true if total.count > number_of_results
end

def crypto_major(crypto_name)
  crypt_array = crypto_query
  crypt_array.select { |k| k[crypto_name] }.empty?
end

# crypto_query
