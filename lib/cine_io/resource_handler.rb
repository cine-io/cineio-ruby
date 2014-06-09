class CineIo::ResourceHandler

  protected

  def initialize(client)
    @client = client
  end

  def get_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    uri.query = URI.encode_www_form({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = (uri.scheme == "https")
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def post_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

  def delete_resource(path, params={})
    uri = URI.parse("#{CineIo::BASE_URL}#{path}")
    request = Net::HTTP::Delete.new(uri.request_uri)
    request.set_form_data({:secretKey => @client.config.fetch(:secretKey)}.merge(params))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    response = http.request(request)

    raise CineIo::ApiError.new(response.body) unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end

end
