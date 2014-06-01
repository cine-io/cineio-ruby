class CineIo::StreamsHandler < CineIo::ResourceHandler

  def get(stream_id)
    CineIo::Stream.new get_resource("/stream", id: stream_id)
  end

  def create
    CineIo::Stream.new post_resource("/stream")
  end

end
