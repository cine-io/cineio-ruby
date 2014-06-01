require "cine_io/version"
require 'net/http'
require 'json'
Dir[File.dirname(__FILE__) + '/cine_io/*.rb'].each {|file| require file }

module CineIo
  API_VERSION = 1
  BASE_URL = "https://www.cine.io/api/#{API_VERSION}/-"
  ApiError = Class.new(StandardError)

  class Client
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def projects
      @projects ||= CineIo::ProjectsHandler.new(self)
    end

    def streams
      @streams ||= CineIo::StreamsHandler.new(self)
    end

    def get(path, params={})
      uri = URI.parse("#{CineIo::BASE_URL}#{path}")
      uri.query = URI.encode_www_form({:secretKey => @config.fetch(:secretKey)}.merge(params))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      http.use_ssl = (uri.scheme == "https")
      response = http.request(request)

      throw new CineIO::ApiError(response.body) unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    end

    def post(path, params={})
      uri = URI.parse("#{CineIo::BASE_URL}#{path}")
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({:secretKey => @config.fetch(:secretKey)}.merge(params))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      response = http.request(request)

      throw CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    end
  end
end
