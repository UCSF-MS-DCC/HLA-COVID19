class UpdateFkConstraintsSubjectRelatedTables < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:subjects, :projects)
      remove_foreign_key(:subjects, :projects)
      add_foreign_key :subjects, :projects, on_delete: :cascade
    end
    if foreign_key_exists?(:c19_symptoms, :subjects)
      remove_foreign_key(:c19_symptoms, :subjects)
      add_foreign_key :c19_symptoms, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:comorbidities, :subjects)
      remove_foreign_key(:comorbidities, :subjects)
      add_foreign_key :comorbidities, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:hlas, :subjects)
      remove_foreign_key(:hlas, :subjects)
      add_foreign_key :hlas, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:lab_tests, :subjects)
      remove_foreign_key(:lab_tests, :subjects)
      add_foreign_key :lab_tests, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:hospitalizations, :subjects)
      remove_foreign_key(:hospitalizations, :subjects)
      add_foreign_key :hospitalizations, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:risk_factors, :subjects)
      remove_foreign_key(:risk_factors, :subjects)
      add_foreign_key :risk_factors, :subjects, on_delete: :cascade
    end
    if foreign_key_exists?(:treatments, :subjects)
      remove_foreign_key(:treatments, :subjects)
      add_foreign_key :treatments, :subjects, on_delete: :cascade
    end
  end
end
