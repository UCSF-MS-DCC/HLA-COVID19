class ProjectController < ApplicationController
    def index
        authenticate_user!
        @user_owned_projects = current_user.projects
        user_approved_access = current_user.approved_access
        @projects = current_user.projects.concat(Project.where(id:current_user.approved_access))
        @current_project = (params[:project_id].nil?) ? current_user.projects.first : current_user.projects.find(params[:project_id])
        @manage_projects = Project.where(id: current_user.grant_project_access_to)
    end


end