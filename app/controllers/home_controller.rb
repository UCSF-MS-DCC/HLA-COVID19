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
        @projects = current_user.projects
    end
    def approve_users
        @user = User.find(approved_users_params[:user].to_i)
        approved_list = approved_users_params[:approved] == "true" ? @user.approved_access.concat([approved_users_params[:project].to_i]) : @user.approved_access - [approved_users_params[:project].to_i]
        @user.update_attributes(approved_access:approved_list)

        status = (@user.approved_access.include?(approved_users_params[:project].to_i)) ? "access approved" : "no access"
        respond_to do |format|
            format.json { render json: {"user_status": status }, status: :ok}
        end
    end
    def age_data
        results = ActiveRecord::Base.connection.execute("select age, count(*) from subjects s join projects p on s.project_id = p.id where p.id < 2 or p.id > 10 group by s.age")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        results = ActiveRecord::Base.connection.execute("select sex, count(*) from subjects s join projects p on s.project_id = p.id where p.id < 2 or p.id > 10 group by s.sex")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def ethnicity_data
        results = ActiveRecord::Base.connection.execute("select ethnicity, count(*) from subjects s join projects p on s.project_id = p.id where p.id < 2 or p.id > 10 group by s.ethnicity")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end

    private

    def approved_users_params
        params.permit(:user, :project, :approved)
    end
end
