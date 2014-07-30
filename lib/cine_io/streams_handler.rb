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

  def recordings
    @streams ||= CineIo::StreamRecordingsHandler.new(@client)
  end

  # params
  #  name: 'some stream name'
  #  record: true|false (default false)
  def create(params={})
    CineIo::Stream.new post_resource("/stream", params)
  end

  # params:
  #  name: some project name
  #  record: true|false (updating a stream from true to false will delete old stream recordings)
  def update(stream_id, params)
    CineIo::Stream.new update_resource("/stream", {id: stream_id}.merge(params))
  end

  def delete(stream_id)
    delete_resource("/stream", id: stream_id).fetch('deletedAt')
  end

end
