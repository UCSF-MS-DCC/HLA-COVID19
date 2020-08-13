class QueryController < ApplicationController
    protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
    acts_as_token_authentication_handler_for User, fallback: :none

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
        logger.info User.all&.size
        subject = Subject.accessible_by(current_ability).find_by(origin_identifier:import_params[:origin_identifier], project_name:import_params[:project_name])
        message = "#{import_params[:origin_identifier]}:"
        success = false
        if !subject
            message += " Can't find subject or don't have permission to add data for subject."
        elsif !subject.hla.nil?
            message += " Subject has an existing HLA record. Contact the admin to update this record."
        else
            message += " Subject found, attempting to insert HLA."
            puts message
            p = import_params.except(:origin_identifier, :project_name)
            p[:subject_id] = subject.id
            h = Hla.new(p)
            if h.save
                message += " HLA successfully added for #{subject[:origin_identifier]}."
                success = true
            else
                message += " There was a problem adding HLA for #{subject[:origin_identifier]}. Error(s): #{h.errors.full_messages}"
            end
        end
        if success == true
            render json: {"log_message": message}, status: :created
        else
            render json: {"log_message": message}, status: :unprocessable_entity
        end

    end

    def check_user_credentials # this method checks that an identified user is permitted to use the HLA imputation tool and has a project in the database
        user = User.find_by(email:check_cred_params[:email])
        if user && user.projects.find_by(name:check_cred_params[:project_name])
            render json: {"message": "User and project found"}, status: :ok
        elsif user && !user.projects.find_by(name:check_cred_params[:project_name])
            render json: {"message": "User's project not found"}, status: :not_acceptable
        else
            render json: {"message": "User not approved"}, status: :not_acceptable
        end 
    end

    private

    def query_params
        params.permit(:subjects, :c19_symptoms, :hlas, :hospitalizations, :lab_tests, :treatments, :risk_factors, :comorbidites)
    end

    def import_params
        params.permit(:origin_identifier, :project_name, :drb1_1, :drb1_2, :dqb1_1, :dqb1_2, :dpb1_1, :dpb1_2, :a_1, :a_2, :b_1, :b_2, :c_1, :c_2,
                    :dpa1_1, :dpa1_2, :dra1_1, :dqa1_1, :dqa1_2, :dra1_2, :drbo_1, :drbo_2, :drb345_1, :drb345_2, :reference_database, :reference_database_version,
                    :typing_method_name, :typing_method_version, :gl_string, :novel_polymorphisms, :pop)
    end
    def check_cred_params
        params.permit(:email, :project_name)
    end

end
