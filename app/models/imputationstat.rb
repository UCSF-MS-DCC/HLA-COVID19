class Imputationstat < ApplicationRecord
  belongs_to :hla, dependent: :destroy
end
