class CineIo::ProjectsHandler < CineIo::ResourceHandler

  def get
    CineIo::Project.new get_resource("/project")
  end

  def delete
    delete_resource("/project").fetch('deletedAt')
  end

end
