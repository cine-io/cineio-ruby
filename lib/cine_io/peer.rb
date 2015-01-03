require 'digest/sha1'

class CineIo::Peer
  def initialize(client)
    @client = client
  end

  def generate_identity_signature(identity)
    secretKey = @client.config.fetch(:secretKey)
    timestamp = Time.now.to_i
    signature = Digest::SHA1.hexdigest "identity=#{identity}&timestamp=#{timestamp}#{secretKey}"
    return {identity: identity, signature: signature, timestamp: timestamp}
  end
end
