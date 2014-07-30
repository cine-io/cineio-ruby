class CineIo::StreamRecordingsHandler < CineIo::ResourceHandler

  def index(stream_id)
     get_resource("/stream/recordings", id: stream_id).map(&CineIo::StreamRecording.method(:new))
  end

  def delete(stream_id, recordingName)
    delete_resource("/stream/recording", id: stream_id, name: recordingName).fetch('deletedAt')
  end

end
