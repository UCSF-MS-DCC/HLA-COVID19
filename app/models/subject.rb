class Subject < ApplicationRecord
    has_one :risk_factor
    has_one :lab_test
    has_one :c19_symptoms
    has_one :hla
    has_one :hospitalization
    has_one :treatment
    has_one :comorbidity
end
