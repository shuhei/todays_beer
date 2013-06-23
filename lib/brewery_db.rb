# coding: utf-8

require 'json'

class BreweryDB
  def random_beer
    path = File.join File.dirname(__FILE__), 'random_beer.json'
    body = File.read  path
    json = JSON.parse body

    id = json['data']['id']
    name = json['data']['name']
    abv = json['data']['abv']
    style = json['data']['style']['name']
    label = json['data']['labels']['large']

    breweries = json['data']['breweries'].map do |b|
      website = b['website'] ? " #{b['website']}" : ''
      b['name'] + website
    end

    message = "#{name}, #{abv}% #{style} by #{breweries.join(', ')} #{label}"
  end
end

