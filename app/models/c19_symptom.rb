class C19Symptom < ApplicationRecord
  belongs_to :subject, dependent: :destroy
end
