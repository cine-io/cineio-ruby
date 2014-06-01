require "cine_io/version"
require 'net/http'
require 'json'
require 'cine_io/resource_handler'
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

    def project
      @project ||= CineIo::ProjectsHandler.new(self)
    end

    def streams
      @streams ||= CineIo::StreamsHandler.new(self)
    end

  end
end
