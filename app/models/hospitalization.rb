class Hospitalization < ApplicationRecord
  belongs_to :subject, dependent: :destroy
end
