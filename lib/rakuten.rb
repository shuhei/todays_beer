# encoding:utf-8

require 'cgi'
require 'open-uri'

module Rakuten
  module StringHelper
    def lower_camelcase str
      upper = upper_camelcase(str)
      "#{upper[0].downcase}#{upper[1..-1]}"
    end

    def upper_camelcase str
      str.to_s.split('_').map(&:capitalize).join
    end
  end

  class Client
    include StringHelper

    def initialize options
      @base_params = {
        application_id: options[:application_id],
        affiliate_id: options[:affiliate_id]
      }

      @version = options[:version]
      @target = options[:target]
    end

    def request_url verb, options
      raise 'No target specified (e.g., IchibaItem)' if @target.nil?
      raise 'No API version specified (e.g., 20130424)' if @version.nil?

      params = options
        .merge(@base_params)
        .map {|k, v| "#{lower_camelcase k}=#{CGI::escape v.to_s}" }
        .join('&')
      camel_verb = verb.to_s.split('_').map(&:capitalize).join
      "https://app.rakuten.co.jp/services/api/#{@target}/#{camel_verb}/#{@version}?#{params}"
    end

    def request verb, options
      url = request_url verb, options
      response = open url
    end

    def method_missing method_id, *params
      request method_id, *params
    end
  end

  class IchibaItem < Client
    def initialize *args
      super *args
      @target = 'IchibaItem'
    end
  end

  class IchibaGenre < Client
    def initialize *args
      super *args
      @target = 'IchibaGenre'
    end
  end
end
