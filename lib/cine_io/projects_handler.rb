class CineIo::ProjectsHandler < CineIo::ResourceHandler

  def get
    CineIo::Project.new get_resource("/project")
  end

  def delete
    delete_resource("/project").fetch('deletedAt')
  end

  # params:
  #  name: some project name
  def update(params)
    CineIo::Project.new update_resource("/project", params)
  end

end
