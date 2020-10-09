class QueryController < ApplicationController
    protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
    acts_as_token_authentication_handler_for User

    def data
        if !current_user
            @user = User.find_by(email:params["user_email"])
        else
        end
        @subjects = Subject.accessible_by(current_ability)
        respond_to do |format|
            format.json { render json: @subjects, each_serializer:SubjectSerializer, hla:query_params[:hlas], c19_symptoms:query_params[:c19_symptoms],
                treatments:query_params[:treatments], hospitalizations: query_params[:hospitalizations], risk_factors:query_params[:risk_factors],
                lab_tests:query_params[:lab_tests], comorbidities:query_params[:comorbidities], status: :ok }
        end
    end
    # endpoint for importing HLA from csv file generated by the HIBAGgerVance shiny app.
    def import_hla
        puts "IMPORT HLA PARAMS: #{import_hla_params}"
        puts "IMPORT STATS PARAMS: #{import_stats_params}"
        message = ""
        if !import_hla_params[:project_name]
            message += "No project name, cannot load data."
            @project = nil
        elsif !current_user.projects.find_by(name:import_hla_params[:project_name]).nil?
            @project = current_user.projects.find_by(name:import_hla_params[:project_name])
            message += "User project #{import_hla_params[:project_name]} found, searching for subject. "
        end
        if @project
            @subject = @project.subjects.find_by(origin_identifier:import_hla_params[:origin_identifier])
            if !@subject.nil?
                message += "Subject #{import_hla_params[:origin_identifier]} found."
            else
                message += "Subject #{import_hla_params[:origin_identifier]} not found."
            end
        else
            message += "User project #{import_hla_params[:project_name]} not found."
            @subject = nil
        end
        #subject = Subject.accessible_by(current_ability).find_by(origin_identifier:import_params[:origin_identifier], project_name:import_params[:project_name])
        success = false
        if @subject 
            if !@subject.hla.nil?
                message += " Subject has an existing HLA record. Contact the admin to update this record."
            else
                p = import_hla_params.except(:origin_identifier, :project_name)
                p[:subject_id] = @subject.id
                h = Hla.new(p)
                if h.save
                    message += " Successfully inserted values #{p.except(:subject_id)}."
                    sp = import_stats_params
                    sp[:hla_id] = h.id
                    i = Imputationstat.new(sp)
                    i.save
                    success = true
                else
                    message += " There was a problem adding HLA for #{@subject[:origin_identifier]}. Error(s): #{h.errors.full_messages}"
                end
            end
        end
        if success == true
            render json: {"log_message": message}, status: :created
        else
            render json: {"log_message": message}, status: :unprocessable_entity
        end
    end

    def hibag_preflight # this method checks that an identified user is permitted to use the HLA imputation tool and has a project in the database
        response_params = {}
        if preflight_params[:email] && User.find_by(email:preflight_params[:email], approved:true, can_upload:true)
            @user = User.find_by(email:preflight_params[:email], approved:true, can_upload:true)
            response_params[:user_approved] = true
        else
            response_params[:user_approved] = false
        end
        if preflight_params[:project_name] && @user && @user.projects.size > 0 && @user.projects.find_by(name:preflight_params[:project_name])
            response_params[:project_found] = true
            @project = @user.projects.find_by(name:preflight_params[:project_name])
        else
            response_params[:project_found] = false
        end
        if preflight_params[:origin_identifiers] && preflight_params[:origin_identifiers].size > 0
            response_params[:origin_identifiers] = {}
            preflight_params[:origin_identifiers].each do |oi|
                if Subject.find_by(origin_identifier:oi)
                    response_params[:origin_identifiers][oi] = "valid"
                else
                    response_params[:origin_identifiers][oi] = "invalid"
                end
            end
        end
        render json: response_params, status: :ok
    end

    def user_key #LOCK THIS DOWN TO THE HLA SIDE LOADER ACCOUNT
        @key = nil
        if current_user.system_user == true
            if user_key_params[:email] && User.find_by(email:user_key_params[:email])
                user = User.find_by(email:user_key_params[:email])
                @key = user.authentication_token
            end
        end
        if @key.nil?
            render json: {"message": "Key not found"}, status: :not_acceptable
        else
            render json: {"key": @key}, status: :ok
        end 
    end

    private

    def query_params
        params.permit(:subjects, :c19_symptoms, :hlas, :hospitalizations, :lab_tests, :treatments, :risk_factors, :comorbidites)
    end

    def import_hla_params
        params.permit(:origin_identifier, :project_name, :drb1_1, :drb1_2, :dqb1_1, :dqb1_2, :dpb1_1, :dpb1_2, :a_1, :a_2, :b_1, :b_2, :c_1, :c_2,
                    :dpa1_1, :dpa1_2, :dra1_1, :dqa1_1, :dqa1_2, :dra1_2, :drbo_1, :drbo_2, :drb345_1, :drb345_2, :reference_database, :reference_database_version,
                    :typing_method_name, :typing_method_version, :gl_string, :novel_polymorphisms, :pop)
    end
    def import_stats_params
        params.permit(:a_prob, :a_matching, :b_prob, :b_matching, :c_prob, :c_matching,
        :drb1_prob, :drb1_matching, :dqa1_prob, :dqa1_matching, :dqb1_prob, :dqb1_matching, :dpb1_prob, :dpb1_matching)
    end
    def preflight_params
        params.permit(:email, :project_name, origin_identifiers: [])
    end
    def user_key_params
        params.permit(:email)
    end

end
