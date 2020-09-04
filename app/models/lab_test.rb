class LabTest < ApplicationRecord
    belongs_to :subject, dependent: :destroy
    has_paper_trail
end
