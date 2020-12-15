# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_11_222724) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "c19_symptoms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "dry_cough"
    t.boolean "mucus_cough"
    t.integer "days_cough"
    t.boolean "difficulty_breathing"
    t.boolean "fever"
    t.integer "highest_temp"
    t.integer "days_fever"
    t.boolean "fatigue"
    t.boolean "pain_chest_heart"
    t.boolean "pain_back"
    t.boolean "runny_nose"
    t.boolean "sore_throat"
    t.text "loss_taste_smell"
    t.boolean "diarrhea"
    t.boolean "nausea"
    t.text "other_symptoms"
    t.boolean "c19_test_result_positive"
    t.string "type_of_c19_test"
    t.index ["subject_id"], name: "index_c19_symptoms_on_subject_id"
  end

  create_table "comorbidities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hiv"
    t.decimal "cd4_cell_count", precision: 10
    t.decimal "hiv_load", precision: 10
    t.boolean "immunocompromised"
    t.boolean "organ_transplant"
    t.text "organ_transplant_type"
    t.boolean "bone_marrow_transplant"
    t.boolean "autoimmune_rheum_disease"
    t.boolean "diabetes_type_1"
    t.boolean "diabetes_type_2"
    t.boolean "asthma"
    t.boolean "copd"
    t.boolean "cycstic_fib"
    t.boolean "liver_disease"
    t.boolean "gallbladder_disease"
    t.boolean "pancreas_disease"
    t.boolean "angio_coronary_intervention"
    t.boolean "artery_bypass"
    t.boolean "cong_heart_failure"
    t.boolean "hypertension"
    t.boolean "infarction_type_1"
    t.boolean "infarction_type_2"
    t.boolean "peri_vascular_dis"
    t.boolean "stroke"
    t.boolean "arythmia"
    t.boolean "dementia"
    t.boolean "neur_disease"
    t.boolean "leukemia"
    t.boolean "lymphoma"
    t.boolean "malignant_solid_tumor"
    t.index ["subject_id"], name: "index_comorbidities_on_subject_id"
  end

  create_table "hlas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "drb1_1"
    t.string "drb1_2"
    t.text "dqb1_1"
    t.text "dqb1_2"
    t.text "dpb1_1"
    t.text "dpb1_2"
    t.text "a_1"
    t.text "a_2"
    t.text "b_1"
    t.text "b_2"
    t.text "c_1"
    t.text "c_2"
    t.text "dpa1_1"
    t.text "dpa1_2"
    t.text "dqa1_1"
    t.text "dqa1_2"
    t.boolean "drbo_1"
    t.boolean "drbo_2"
    t.text "drb345_1"
    t.string "drb345_2"
    t.text "reference_database"
    t.text "reference_database_version"
    t.text "typing_method_name"
    t.text "typing_method_version"
    t.text "gl_string"
    t.text "novel_polymorphisms"
    t.string "pop"
    t.boolean "imputed_using_hlacovid_platform", default: false
    t.index ["subject_id"], name: "index_hlas_on_subject_id"
  end

  create_table "hospitalizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "icu_admit"
    t.integer "icu_duration_days"
    t.text "reason_hosp_ended"
    t.boolean "septic_shock"
    t.integer "days_after_c19_septic_shock"
    t.boolean "organ_failure"
    t.boolean "resp_failure"
    t.text "resp_rate_intake"
    t.integer "resp_breath_per_min"
    t.decimal "blood_o2_sat", precision: 10
    t.text "highest_resp_support"
    t.integer "days_ventilator"
    t.decimal "pa02_min", precision: 10
    t.decimal "fio2_max", precision: 10
    t.decimal "lung_infiltrates", precision: 10
    t.text "pneumonia"
    t.integer "pneumonia_days_after_c19_symptoms"
    t.decimal "ef_echo", precision: 10
    t.boolean "hepatitis"
    t.boolean "pancreatitis"
    t.boolean "pleural_effusion"
    t.boolean "acute_kidney_failure"
    t.boolean "acute_kidney_chronic"
    t.boolean "ascites"
    t.boolean "dyspnea"
    t.integer "hospitalization_duration_days"
    t.boolean "hospitalization_admit"
    t.index ["subject_id"], name: "index_hospitalizations_on_subject_id"
  end

  create_table "imputationstats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "hla_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "a_prob"
    t.string "a_matching"
    t.string "b_prob"
    t.string "b_matching"
    t.string "c_prob"
    t.string "c_matching"
    t.string "drb1_prob"
    t.string "drb1_matching"
    t.string "dqa1_prob"
    t.string "dqa1_matching"
    t.string "dqb1_prob"
    t.string "dqb1_matching"
    t.string "dpb1_prob"
    t.string "dpb1_matching"
    t.string "dpb1_1"
    t.string "dpb1_2"
    t.string "typing_method_name"
    t.string "typing_method_version"
    t.string "population"
    t.index ["hla_id"], name: "index_imputationstats_on_hla_id"
  end

  create_table "lab_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "blood_type"
    t.text "rh_factor"
    t.text "wbc"
    t.text "lymphocytes"
    t.text "neutrophils"
    t.text "monocytes"
    t.text "eosinophils"
    t.text "basophils"
    t.text "crp"
    t.text "trop_i"
    t.text "trop_t"
    t.text "bnp"
    t.text "idh"
    t.text "ast"
    t.text "alt"
    t.text "bilirubin"
    t.text "ggt"
    t.text "alp"
    t.text "d_dimer"
    t.text "il6"
    t.text "tumor_necrosis_factor"
    t.text "serum_femtin"
    t.text "hba1c"
    t.text "cholesterol"
    t.text "triglycerides"
    t.text "hdl"
    t.text "ldl"
    t.text "ace"
    t.text "ace2r"
    t.text "hemoglobin"
    t.text "amylase"
    t.text "lipase"
    t.text "urea"
    t.text "creatinine"
    t.bigint "subject_id"
    t.index ["subject_id"], name: "index_lab_tests_on_subject_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "read_counts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "hla_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hla_a"
    t.integer "hla_b"
    t.integer "hla_c"
    t.integer "hla_dpa1"
    t.integer "hla_dpb1"
    t.integer "hla_dqa1"
    t.integer "hla_dqb1"
    t.integer "hla_drb1"
    t.integer "hla_drb3"
    t.integer "hla_drb4"
    t.integer "hla_drb5"
    t.index ["hla_id"], name: "index_read_counts_on_hla_id"
  end

  create_table "risk_factors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "smoke_freq"
    t.text "alcohol_freq"
    t.text "substances_freq"
    t.boolean "smoke"
    t.index ["subject_id"], name: "index_risk_factors_on_subject_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hlac19_id"
    t.string "origin_identifier"
    t.string "country_of_residence"
    t.text "sex"
    t.text "gender"
    t.boolean "education"
    t.integer "age"
    t.text "ethnicity"
    t.boolean "pregnant"
    t.text "ancestry"
    t.integer "height_cm"
    t.integer "weight_kg"
    t.string "project_name"
    t.text "race"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_subjects_on_project_id"
  end

  create_table "treatments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ace_inhib"
    t.text "angio_blocker"
    t.text "antibiotics"
    t.text "antiviral_med"
    t.text "allergy_med"
    t.text "androgen_med"
    t.text "asthma_med"
    t.text "immunosuppressor_light"
    t.text "immunosuppressor_strong"
    t.text "biologics_mabs"
    t.text "nsaid"
    t.text "antipytetics"
    t.text "blood_thinner"
    t.text "vitamin_d_med"
    t.text "vitamin_c_med"
    t.text "med_udca"
    t.integer "treatment_duration_days"
    t.index ["subject_id"], name: "index_treatments_on_subject_id"
  end

  create_table "upload_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "active_storage_attachment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subjects"
    t.string "bad_columns"
    t.boolean "csv_file"
    t.boolean "irb_approved_checkbox"
    t.string "upload_filename"
    t.string "uploaded_by"
    t.string "upload_type"
    t.string "project"
    t.index ["active_storage_attachment_id"], name: "index_upload_records_on_active_storage_attachment_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rstudio", default: true
    t.boolean "approved", default: false
    t.text "affiliation"
    t.integer "upload_count", default: 0
    t.boolean "can_upload", default: true
    t.string "rstudio_username"
    t.string "rstudio_password"
    t.string "authentication_token", limit: 30
    t.string "approved_access"
    t.boolean "project_owner", default: true
    t.string "project_name"
    t.boolean "system_user", default: false, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "email_opt_in"
    t.boolean "notified_of_approval", default: false, null: false
    t.boolean "admin_access", default: false
    t.boolean "can_approve_new_user", default: false
    t.boolean "suppress_from_approval_view", default: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "c19_symptoms", "subjects", on_delete: :cascade
  add_foreign_key "comorbidities", "subjects", on_delete: :cascade
  add_foreign_key "hlas", "subjects", on_delete: :cascade
  add_foreign_key "hospitalizations", "subjects", on_delete: :cascade
  add_foreign_key "imputationstats", "hlas"
  add_foreign_key "projects", "users", on_delete: :cascade
  add_foreign_key "read_counts", "hlas"
  add_foreign_key "risk_factors", "subjects", on_delete: :cascade
  add_foreign_key "subjects", "projects", on_delete: :cascade
  add_foreign_key "treatments", "subjects", on_delete: :cascade
  add_foreign_key "upload_records", "active_storage_attachments"
end
