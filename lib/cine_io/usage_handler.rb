require 'time'

class CineIo::UsageHandler < CineIo::ResourceHandler

  def project(options)
    params = {
      :month => options.fetch(:month).utc.iso8601,
      :report => options.fetch(:report)
    }
    get_resource("/usage/project", params)
  end

  def stream(id, options)
    params = {
      :month => options.fetch(:month).utc.iso8601,
      :report => options.fetch(:report),
      :id => id
    }
    get_resource("/usage/stream", params)
  end

end
