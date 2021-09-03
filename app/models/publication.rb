class Publication < ApplicationRecord
  has_many :publication_subjects
  has_many :subjects, through: :publication_subjects
end
