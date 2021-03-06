class CineIo::StreamRecording

  attr_reader :name, :url, :size, :date, :deletedAt

  def initialize(attributes)
    attributes.each do |attribute, value|
      instance_variable_set "@#{attribute}", value
    end
  end

end
