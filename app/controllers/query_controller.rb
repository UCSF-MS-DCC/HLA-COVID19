class QueryController < ApplicationController
    protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
    acts_as_token_authentication_handler_for User, fallback: :none

    def data
        @subjects = Subject.accessible_by(current_ability)
        respond_to do |format|
            format.json { render json: @subjects, each_serializer:SubjectSerializer, hla:query_params[:hlas], c19_symptoms:query_params[:c19_symptoms],
                treatments:query_params[:treatments], hospitalizations: query_params[:hospitalizations], risk_factors:query_params[:risk_factors],
                lab_tests:query_params[:lab_tests], comorbidities:query_params[:comorbidities], status: :ok }
        end
    end

    private

    def query_params
        params.permit(:subjects, :c19_symptoms, :hlas, :hospitalizations, :lab_tests, :treatments, :risk_factors, :comorbidites)
    end

end