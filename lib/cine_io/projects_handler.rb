class CineIo::ProjectsHandler < CineIo::ResourceHandler

  def index
    get_resource_with_master_key("/projects").map(&CineIo::Project.method(:new))
  end

end
