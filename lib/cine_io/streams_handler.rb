class CineIo::StreamsHandler < CineIo::ResourceHandler

  def index
     get_resource("/streams").map(&CineIo::Stream.method(:new))
  end

  def get(stream_id)
    CineIo::Stream.new get_resource("/stream", id: stream_id)
  end

  def fmle_profile(stream_id)
    get_resource("/stream", id: stream_id, fmleProfile: true).fetch('content')
  end

  def create
    CineIo::Stream.new post_resource("/stream")
  end

end
