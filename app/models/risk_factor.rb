class RiskFactor < ApplicationRecord
  belongs_to :subject, dependent: :destroy
end
