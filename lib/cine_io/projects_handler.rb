class CineIo::ProjectsHandler < CineIo::ResourceHandler

  def get
    CineIo::Project.new get_resource("/project")
  end

end
