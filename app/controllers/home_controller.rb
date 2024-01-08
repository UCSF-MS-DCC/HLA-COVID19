class HomeController < ApplicationController
    def index
        test_pids = Project.where(is_test:true).pluck(:id)
        @subjects_n = Subject.where.not(project_id:test_pids).count
        subject_ids = Project.where.not(id:test_pids).map{ |p| p.subjects.pluck(:id) }.flatten
        @all_hlas_n = Hla.where(subject_id:subject_ids).count
        @hla_genes = Hla.column_names.reject{ |cn| ["id", "subject_id", "updated_at", "created_at", "reference_database", "reference_database_version", "typing_method_name", "typing_method_version", "gl_string", "novel_polymorphisms", "pop", "imputed_using_hlacovid_platform", "drbo_1", "drbo_2", "drb345_1", "drb345_2"].include? cn }
        @hla_genes = @hla_genes.map{ |g| g.split("_").first}.uniq
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
        # 02-26-2021 removed a broken method to show projects that a user doesn't own, but has access to. 
        # This will now only serve current_user's projects.
        # Will add a method to serve up other projects if there is a need for it
        authenticate_user!
        @user_owned_projects = current_user.projects
    end
    def approve_users
        @user = User.find(approved_users_params[:user].to_i)
        approved_list = approved_users_params[:approved] == "true" ? @user.approved_access.concat([approved_users_params[:project].to_i]) : @user.approved_access - [approved_users_params[:project].to_i]
        @user.update(approved_access:approved_list)
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
        @user = User.find_by(email:account_approval_params[:email])
        if @user && @user.update(account_approval_params)
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
    def kir_csv
        @project = Project.find(params[:id])
        respond_to do |format|
            format.csv { send_data @project.get_kir, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=#{@project.name}_KIR.csv" }
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
        results = ActiveRecord::Base.connection.execute("select age, count(s.id) from subjects s join projects p on s.project_id = p.id where p.is_test = false group by s.age")
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        results = ActiveRecord::Base.connection.execute("select sex, count(s.id) from subjects s join projects p on s.project_id = p.id where p.is_test = false and sex in ('M','F') group by s.sex")
        puts results.to_json
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def allele_freq_data
        gp1 = "#{allele_freq_data_params[:gene]}_1"
        gp2 = "#{allele_freq_data_params[:gene]}_2"
        query_1 = "SELECT h.#{gp1} as allele, count(h.id) as n from hlas h join subjects s on h.subject_id = s.id where s.project_id in (1, 10, 11, 17, 19, 22) group by h.#{gp1}"
        query_2 = "SELECT h.#{gp2} as allele, count(h.id) as n from hlas h join subjects s on h.subject_id = s.id where s.project_id in (1, 10, 11, 17, 19, 22) group by h.#{gp2}"
        result_1 = ActiveRecord::Base.connection.exec_query(query_1)
        result_2 = ActiveRecord::Base.connection.exec_query(query_2)

        freq_hash = {}
        # AGGREGATE THE TOTALS FROM THE SINGLE GENE COUNT QUERIES INTO ONE HASH
        [result_1, result_2].each do |r|
            r.each do |h|
                gls = h["allele"]
                # NORMALIZE ALLELE STRINGS: STRIP OFF GENE PREFIX, SHORTEN AMBIGUOUS CALLS, CONDENSE GL STRINGS TO 2 FIELDS, AND INSERT LEADING ZEROES WHERE NEEDED
                unless gls.nil?
                    gls = (gls.include? "*") ? gls.split("*")[1] : gls # STRIP GENE NAMES
                    gls = (gls.include? "/") ? gls.split("/")[0] : gls # SHORTEN AMBIGUOUS CALLS
                    gls = (gls.scan(':').size > 1) ? "#{gls.split(':').first}:#{gls.split(':').second}" : gls # CONDENSE GL STRINGS TO TWO FIELDS 
                    gls = (/^\d{1}:/.match(gls)) ? "#{gls.split(':').first.rjust(2, '0')}:#{gls.split(':').second}" : gls # ADD LEADING ZEROES IF FIRST FIELD IS ONLY ONE DIGIT
                    gls = (/^\d{1}$/.match(gls)) ? "#{gls.rjust(2, '0')}" : gls
                    # BEFORE ADDING TO THE FREQUENCY HASH CHECK TO SEE THAT THE GENE NAME ISN'T 'NA' OR 'INSERTION' OR ANYTHING THAT ISN'T A VALID GL STRING. IF IT IS, SKIP TO THE NEXT ALLELE
                    unless /^[0-9]/.match? gls.to_s
                        next
                    end
                    if freq_hash[gls]
                        freq_hash[gls] += h["n"]
                    else
                        freq_hash[gls] = h["n"]
                    end
                end
            end
        end
        # DETERMINE EACH GENOTYPE'S FREQUENCY BY DIVIDING EACH GENOTYPE'S COUNT BY 2X THE TOTAL HLA (BY THE NUMBER OF NON-NULL VALID GENOTYPES FOR THAT GENE)
        #gp1_count = ActiveRecord::Base.connection.execute("SELECT count(h.id) from hlas h join subjects s on h.subject_id = s.id where h.#{gp1} is not null and h.#{gp1} <> 'NA' and h.#{gp1} <> 'insertion/deletion' and s.project_id in (1, 10, 11, 17, 19, 22)")
        gp1_count = ActiveRecord::Base.connection.execute("SELECT count(h.id) from projects p join subjects s on p.id = s.project_id join hlas h on h.subject_id = s.id where h.#{gp1} is not null and h.#{gp1} <> 'NA' and h.#{gp1} <> 'insertion/deletion' and p.is_test = false")
        #gp2_count = ActiveRecord::Base.connection.execute("SELECT count(h.id) from hlas h join subjects s on h.subject_id = s.id where h.#{gp2} is not null and h.#{gp2} <> 'NA' and h.#{gp2} <> 'insertion/deletion' and project_id in (1, 10, 11, 17, 19, 22)")
        gp2_count = ActiveRecord::Base.connection.execute("SELECT count(h.id) from projects p join subjects s on p.id = s.project_id join hlas h on h.subject_id = s.id where h.#{gp2} is not null and h.#{gp2} <> 'NA' and h.#{gp2} <> 'insertion/deletion' and p.is_test = false")
        sample_n = gp1_count.to_a.first.first + gp2_count.to_a.first.first
        dataMatrix = []
        
        freq_hash.each do |al, n|
            unless sample_n == 0
                dataMatrix.push([al, ((n.to_f)/sample_n.to_f).round(5)])
            end
        end

        dataMatrix = dataMatrix.sort_by{ |tup| tup[0] }
        dataMatrix.unshift(["Allele", "Frequency"])
        respond_to do |format|
            format.json { render json: { :data => dataMatrix }, status: :ok }
        end

    end

    def contributor_table_data
        @projects = Project.where(is_test: false)
        data_hash = {:colnames => ["Project Owner", "Subjects", "Publication"], :members => {} }
        @projects.each do |p|
            sub_pubs = PublicationSubject.where(subject_id:p.subjects.pluck(:id)).pluck(:publication_id).uniq
            pubs = Publication.where(id:sub_pubs).count > 0 ? Publication.where(id:sub_pubs).pluck(:url).uniq.join(", ") : nil
            data_hash[:members][p.name] = { :n => p.subjects.count, :pub_url =>  pubs }
        end
        respond_to do |format|
            format.json { render json: { :data => data_hash }, status: :ok }
        end
    end

    def download_manual
        send_file "public/UploadResources/HCDB_Database_Manual_v2.1.pdf", type: 'application/pdf'
    end

    private

    def approved_users_params
        params.permit(:user, :project, :approved)
    end

    def account_approval_params
        params.permit(:email, :approved, :suppress_from_approval_view)
    end

    def allele_freq_data_params
        params.permit(:gene)
    end
end
