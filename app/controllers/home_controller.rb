class HomeController < ApplicationController
    def index
        if current_user
            @user = current_user
        else
            @user = User.new
        end
    end
    def auth
        unless current_user
            @user = User.new
        end
    end
    def account
    end
    def access
        @project = current_user.project_owner.first
    end
    def approve_users
        puts "APPROVED USERS PARAMS: #{approved_users_params}"
        @user = User.find_by(email:approved_users_params[:email])
        proj_list = @user.approved_access
        approval_status = approved_users_params[:approved]
        project = approved_users_params[:project_name]
        status_flag = nil

        if approval_status == "true"
            unless proj_list.include? project
                proj_list.push(project)
                status_flag = "access approved"
            end
        end
        if approval_status == "false"
            idx = proj_list.index(project)
            proj_list.delete_at(idx)
            puts proj_list
            status_flag = "access removed"
        end
        if @user.update_attributes(approved_access:proj_list)
            respond_to do |format|
                format.json { render json: {"user_status": status_flag}, status: :ok}
            end
        else
            respond_to do |format|
                format.json { render json: {"error": "could not approve this user"}, status: :unprocessable_entity}
            end
        end

    end
    def age_data
        results = ActiveRecord::Base.connection.execute("select age, count(*) from subjects group by age")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        results = ActiveRecord::Base.connection.execute("select sex, count(*) from subjects group by sex")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def ethnicity_data
        results = ActiveRecord::Base.connection.execute("select ethnicity, count(*) from subjects group by ethnicity")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end

    private

    def approved_users_params
        params.permit(:project_name, :email, :approved)
    end
end
