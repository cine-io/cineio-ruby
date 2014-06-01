class CineIo::ProjectsHandler

  def initialize(client)
    @client = client
  end

  def get
    CineIo::Project.new @client.get "/project"
  end

end
