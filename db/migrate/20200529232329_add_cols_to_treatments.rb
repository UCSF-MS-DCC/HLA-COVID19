class AddColsToTreatments < ActiveRecord::Migration[5.2]
  def change
    add_column :treatments, :start_date, :date
    add_column :treatments, :end_date, :date
    add_column :treatments, :ace_inhib, :text
    add_column :treatments, :angio_blocker, :text
    add_column :treatments, :antibiotics, :text
    add_column :treatments, :antiviral_med, :text
    add_column :treatments, :allergy_med, :text
    add_column :treatments, :androgen_med, :text
    add_column :treatments, :asthma_med, :text
    add_column :treatments, :immunosuppressor_light, :text
    add_column :treatments, :immunosuppressor_strong, :text
    add_column :treatments, :biologics_mabs, :text
    add_column :treatments, :nsaid, :text
    add_column :treatments, :antipytetics, :text
    add_column :treatments, :blood_thinner, :text
    add_column :treatments, :vitamin_d_med, :text
    add_column :treatments, :vitamin_c_med, :text
    add_column :treatments, :med_udca, :text
  end
end
