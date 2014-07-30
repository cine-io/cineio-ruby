class CineIo::Stream

  attr_reader :id, :name, :play, :publish, :password, :expiration, :assignedAt, :record, :deletedAt

  def initialize(attributes)
    attributes.each do |attribute, value|
      instance_variable_set "@#{attribute}", value
    end
  end

end
