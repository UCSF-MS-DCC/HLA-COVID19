class Treatment < ApplicationRecord
    belongs_to :subject, dependent: :destroy
end
