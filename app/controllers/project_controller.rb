class ProjectController < ApplicationController
    def index
        authenticate_user!
        @user_owned_projects = current_user.projects
        @current_project = (params[:project_id].nil?) ? current_user.projects.first : current_user.projects.find(params[:project_id])
    end


end