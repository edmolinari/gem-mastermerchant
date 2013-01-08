module MasterMerchant::Connection
  extend ActiveSupport::Concern

  module ClassMethods
    def index(options={})
      set_config_from_options(options)
      _typhoeus_options = {
        :headers => {'content-type' => 'application/json'},
      }.merge(config.typhoeus_options)
      Typhoeus::Request.get collection_url(options), _typhoeus_options
    end

    def get(options={})
      set_config_from_options(options)
      _typhoeus_options = {
        :headers => {'content-type' => 'application/json'},
      }.merge(config.typhoeus_options)
      Typhoeus::Request.get member_url(options), _typhoeus_options
    end

    def post(json, options={})
      set_config_from_options(options)
      _typhoeus_options = {
        :headers => {'content-type' => 'application/json'},
        :body => json,
      }.merge(config.typhoeus_options)
      Typhoeus::Request.post collection_url(options), _typhoeus_options
    end

    def put(json, options={})
      set_config_from_options(options)
      _typhoeus_options = {
        :headers => {'content-type' => 'application/json'},
        :body => json,
      }.merge(config.typhoeus_options)
      Typhoeus::Request.put member_url(options), _typhoeus_options
    end

    def process_url(url, options={})
      options[:site_url] ||= config.site_url
      url = options.inject(url) do |map, (key, _)|
        if map.include?(":#{key}")
          map = map.gsub ":#{key}", options.delete(key).to_s
        end
        map
      end
      puts "#{url}?#{options.to_query}"
      "#{url}?#{options.to_query}"
    end

    def set_config_from_options(options={})
      self.config = options.delete(:config) if options[:config]
    end

    def process_response(klass, key, response)
      puts response.body if config.typhoeus_options[:debug]
      handle_not_found response if response.code == 404
      handle_failed response unless response.success?

      begin
        body = JSON.parse(response.body)
      rescue JSON::ParserError => e
        raise MasterMerchant::ParseError.new response, e
      end

      if body.is_a?(Array)
        process_collection(klass, body)
      else
        if body['pagination'] && body['results']
          process_paginated_collection(klass, body)
        else
          process_instance(klass, body[key] || body)
        end
      end
    end

    def process_instance(klass, attrs)
      obj = klass.new attrs
      obj.config = self.config
      obj
    end

    def process_paginated_collection(klass, body)
      results = if body['results'] && body['results'].is_a?(Array)
                  body['results'].map { |h| process_instance(klass, h) }
                else
                  []
                end

      MasterMerchant::Collection.new(body['pagination'], results)
    end

    def process_collection(klass, body)
      body.map {|h| process_instance(klass, h) }
    end

    def handle_not_found(response)
      raise MasterMerchant::ResourceNotFound.new response
    end
    def handle_failed(response)
      raise MasterMerchant::BadRequest.new response
    end
  end

  include ClassMethods
end
