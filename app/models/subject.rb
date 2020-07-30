class Subject < ApplicationRecord
    has_one :risk_factor, dependent: :destroy
    has_many :lab_test, dependent: :delete_all
    has_many :c19_symptom, dependent: :delete_all
    has_one :hla, dependent: :destroy
    has_many :hospitalization, dependent: :delete_all
    has_many :treatment, dependent: :delete_all
    has_many :comorbidity, dependent: :destroy

    after_create :assign_hla_covid_db_id
    # before_delete :delete_related_rows

    def assign_hla_covid_db_id
        id = self.id + 300
        newid = "HCC#{id.to_s.rjust(6,'0')}"
        self.update_attributes(hlac19_id:newid)
    end

    def delete_related_rows
        if self.c19_symptom
            self.c19_symptoms.destroy_all
        end
        if self.comorbidity
            self.comorbidity.destroy
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
    end

end
