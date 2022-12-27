class Subject < ApplicationRecord
    belongs_to :project
    has_one :risk_factor, dependent: :destroy
    has_many :lab_tests, dependent: :delete_all
    has_many :c19_symptoms, dependent: :delete_all
    has_one :hla, dependent: :destroy
    has_many :hospitalizations, dependent: :delete_all
    has_many :treatments, dependent: :delete_all
    has_many :comorbidities, dependent: :destroy
    has_one :kir, dependent: :destroy
    has_many :publication_subjects
    has_many :publications, through: :publication_subjects
    has_paper_trail

    after_create :assign_hla_covid_db_id
    # before_delete :delete_related_rows

    def assign_hla_covid_db_id
        id = self.id + 300
        newid = "HCC#{id.to_s.rjust(6,'0')}"
        self.update(hlac19_id:newid)
    end

    def delete_related_rows
        if self.c19_symptom
            self.c19_symptoms.destroy_all
        end
        if self.comorbidity
            self.comorbidity.destroy_destroy_all
        end
        if self.hla
            self.hla.destroy
        end
        if self.hospitalization
            self.hospitalizations.destroy_all
        end
        if self.lab_test
            self.lab_tests.destroy_all
        end
        if self.risk_factor
            self.risk_factor.destroy
        end
        if self.treatment
            self.treatments.destroy_all
        end
        if self.kir
            self.kir.destroy
        end
    end

end
