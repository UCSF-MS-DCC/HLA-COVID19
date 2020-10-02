class HomeController < ApplicationController
    def index
        @subjects_n = Subject.count
        @all_hlas_n = Hla.where(project_id:[1,8,10]).count
        @imputed_hlas_n = Hla.where(project_id:[1,8,10]).where(imputed_using_hlacovid_platform:true).count
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
    def project
        authenticate_user!
        @user_owned_projects = current_user.projects
        user_access_project_ids = current_user.approved_access.reject!{ |aa| current_user.projects.pluck(:id).include? aa }.map{ |aa| aa.to_i }
        puts "IDS: #{user_access_project_ids}"
        @user_access_projects = Project.where(id:user_access_project_ids)
        puts "PROJECTS#{@user_access_projects.pluck(:name)}"
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
    def hla_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_hla, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_HLA.csv" }
        end
    end
    def stats_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_stats, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_Imputation_stats.csv" }
        end
    end

    def age_data
        results = ActiveRecord::Base.connection.execute("select age, count(*) from subjects s join projects p on s.project_id = p.id where p.id < 2 or p.id >=10 group by s.age")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        results = ActiveRecord::Base.connection.execute("select sex, count(*) from subjects s join projects p on s.project_id = p.id where p.id < 2 or p.id >= 10 group by s.sex")
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
