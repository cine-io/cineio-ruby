class CineIo::Project

  attr_reader :id, :publicKey, :secretKey, :name, :streamsCount, :updatedAt, :deletedAt

  def initialize(attributes)
    attributes.each do |attribute, value|
      instance_variable_set "@#{attribute}", value
    end
  end

end
