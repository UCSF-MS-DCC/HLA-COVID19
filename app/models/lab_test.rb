class LabTest < ApplicationRecord
    belongs_to :subject, dependent: :destroy
end
