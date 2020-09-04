class C19Symptom < ApplicationRecord
  belongs_to :subject
  has_paper_trail
end

