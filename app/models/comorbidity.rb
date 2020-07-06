class Comorbidity < ApplicationRecord
  belongs_to :subject, dependent: :destroy
end
