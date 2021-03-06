class DatatablesController < ApplicationController

    def subjects
        respond_to do |format|
            format.html
            format.json { render json: SubjectDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def c19_symptoms
        respond_to do |format|
            format.html
            format.json { render json: C19SymptomDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def hla
        respond_to do |format|
            format.html
            format.json { render json: HlaDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def kir 
        puts "KIR CONTROLLER METHOD CALLED"
        respond_to do |format|
            format.html
            format.json { render json: KirDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def comorbidity 
        respond_to do |format|
            format.html
            format.json { render json: ComorbidityDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def hospitalization 
        respond_to do |format|
            format.html
            format.json { render json: HospitalizationDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def labtest
        respond_to do |format|
            format.html
            format.json { render json: LabTestDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def riskfactor
        respond_to do |format|
            format.html
            format.json { render json: RiskFactorDatatable.new(params, :project_id => params[:project_id]) }
          end
    end

    def treatment 
        respond_to do |format|
            format.html
            format.json { render json: TreatmentDatatable.new(params, :project_id => params[:project_id]) }
          end
    end



end