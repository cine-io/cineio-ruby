class CineIo::StreamsHandler

  def initialize(client)
    @client = client
  end

  def get(stream_id)
    CineIo::Stream.new @client.get("/stream", id: stream_id)
  end

  def create
    CineIo::Stream.new @client.post("/stream")
  end

end
