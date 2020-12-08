class HomeController < ApplicationController
    def index
        @subjects_n = Subject.where(project_id:[1,10,11]).count
        subject_ids = Project.where(id:[1,10,11]).map{ |p| p.subjects.pluck(:id) }.flatten
        @all_hlas_n = Hla.where(subject_id:subject_ids).count
        @imputed_hlas_n = Hla.where(subject_id:subject_ids).where(imputed_using_hlacovid_platform:true).count
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
    def new_account_approval
        unless current_user && (current_user.can_approve_new_user || current_user.admin?)
            redirect_to root_path
        end
        @new_accounts = User.where(approved:false).where(suppress_from_approval_view:false)

    end
    def new_account_approval_handler
        puts account_approval_params
        @user = User.find_by(email:account_approval_params[:email])
        if @user && @user.update_attributes(account_approval_params)
            @status = "OK"
        else
            @status = "ERROR"
        end
        respond_to do |format|
            format.json { render json: {"accepted": @status }, status: :accepted }
        end
    end
    def subjects_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_subjects, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_subjects.csv" }
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
            format.csv { send_data @project.get_stats, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_imputation_stats.csv" }
        end
    end
    def comorbidities_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_comorbidities, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_comorbidities.csv" }
        end
    end
    def c19_symptoms_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_symptoms, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_COVID-19_symptoms.csv" }
        end
    end
    def hospitalizations_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_hospitalizations, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_hospitalizations.csv" }
        end
    end
    def lab_tests_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_lab_tests, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_lab_tests.csv" }
        end
    end
    def risk_factors_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_risk_factors, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_risk_factors.csv" }
        end
    end
    def treatments_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_treatments, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_treatments.csv" }
        end
    end

    def age_data
        results = ActiveRecord::Base.connection.execute("select age, count(*) from subjects s join projects p on s.project_id = p.id where p.id in (1,10,11) group by s.age")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        results = ActiveRecord::Base.connection.execute("select sex, count(*) from subjects s join projects p on s.project_id = p.id where p.id in (1,10,11) group by s.sex")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def allele_freq_data
        col_names = Hla.column_names.reject{ |cn| ["id", "subject_id", "updated_at", "created_at", "reference_database", "reference_database_version", "typing_method_name", "typing_method_version", "gl_string", "novel_polymorphisms", "pop", "imputed_using_hlacovid_platform"].include? cn }
        puts "COLUMN NAMES: #{col_names}"
        sub_query = "SELECT"
        main_query = "SELECT"
        col_names.each_with_index do |cn, idx|
            if idx == 0
                sub_query += " SUBSTRING_INDEX(#{cn},'/',1) as #{cn}"
                main_query += " SUBSTRING_INDEX(s.#{cn},'\*',2) as #{cn}"
            else
                sub_query += ", SUBSTRING_INDEX(#{cn},'/',1) as #{cn}"
                main_query += ", SUBSTRING_INDEX(s.#{cn},'\*',2) as #{cn}"
            end
        end
        sub_query += " from hlas"
        main_query += " from (#{sub_query}) s"
        puts sub_query
        puts main_query
        results = ActiveRecord::Base.connection.exec_query(main_query, name = "SQL", binds = [], prepare: false)
        #puts results.to_json
        freq_hash = {}

        results.each do |r|
            r.each do |k,v|
                key = k.split("_").first
                val = (!v.nil? && (v.include? "*")) ? v.split("*")[1] : v #clean allele values here
                val = (!val.nil? && (val.include? "/")) ? val.split("/")[0] : val
                unless freq_hash[key]
                    freq_hash[key] ={}
                end
                if freq_hash[key][val]
                    freq_hash[key][val] += 1
                else
                    freq_hash[key][val] = 1
                end
            end
        end
        dataMatrix = []
        freq_hash.each do |gene, alleles|
            h = {gene.to_sym => [] }
            puts h
            alleles.each do |a, f|
                h[gene.to_sym].push([a,f])
            end
            dataMatrix.push(h)
        end
        respond_to do |format|
            format.json { render json: { :data => dataMatrix }, status: :ok }
        end
    end

    def download_manual
        send_file "public/UploadResources/HCDB_Database_Manual_v1.pdf", type: 'application/pdf'
    end

    private

    def approved_users_params
        params.permit(:user, :project, :approved)
    end

    def account_approval_params
        params.permit(:email, :approved, :suppress_from_approval_view)
    end
end
