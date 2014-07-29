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

  def recordings(stream_id)
    get_resource("/stream/recordings", id: stream_id).map(&CineIo::StreamRecording.method(:new))
  end

  # params
  #  name: 'some stream name'
  def create(params={})
    CineIo::Stream.new post_resource("/stream", params)
  end

  # params:
  #  name: some project name
  def update(stream_id, params)
    CineIo::Stream.new update_resource("/stream", {id: stream_id}.merge(params))
  end

  def delete(stream_id)
    delete_resource("/stream", id: stream_id).fetch('deletedAt')
  end

end
