class Subject < ApplicationRecord
    has_one :risk_factor
    has_one :lab_test
    has_one :c19_symptom
    has_one :hla
    has_one :hospitalization
    has_one :treatment
    has_one :comorbidity

    before_destroy :delete_related_rows

    def delete_related_rows
        if self.c19_symptom
            self.c19_symptom.destroy
        end
        if self.comorbidity
            self.comorbidity.destroy
        end
        if self.hla
            self.hla.destroy
        end
        if self.hospitalization
            self.hospitalization.destroy
        end
        if self.lab_test
            self.lab_test.destroy
        end
        if self.risk_factor
            self.risk_factor.destroy
        end
        if self.treatment
            self.treatment.destroy
        end
    end

end
