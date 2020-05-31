class Subject < ApplicationRecord
    has_one :hla
    has_one :baseline_c19_survey
    has_many :weekly_c19_surveys
    has_one :family
    has_one :anxiety
    has_one :smoking_history
    has_one :medical_history
    has_one :risk_factor
end
