require('queryparams')

class CineIo::ResourceHandler

  protected

  USER_AGENT = "cineio-ruby version-#{CineIo::VERSION}"

  def initialize(client)
    @client = client
  end

  def get_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    uri.query = QueryParams.encode({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = Net::HTTP::Get.new(uri.request_uri, {"User-Agent" => USER_AGENT})
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def get_resource_with_master_key(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    uri.query = QueryParams.encode({:masterKey => @client.config.fetch(:masterKey)}.merge(params))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = Net::HTTP::Get.new(uri.request_uri, {"User-Agent" => USER_AGENT})
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def post_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = Net::HTTP::Post.new(uri.request_uri, {"User-Agent" => USER_AGENT})
    request.set_form_data({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def update_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = Net::HTTP::Put.new(uri.request_uri, {"User-Agent" => USER_AGENT})
    request.set_form_data({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def delete_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = Net::HTTP::Delete.new(uri.request_uri, {"User-Agent" => USER_AGENT})
    request.set_form_data({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

end
