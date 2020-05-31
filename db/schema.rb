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

ActiveRecord::Schema.define(version: 2020_05_31_170221) do

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
    t.date "c19_test_date"
    t.text "c19_test_result"
    t.boolean "dry_cough"
    t.boolean "mucus_cough"
    t.integer "days_cough"
    t.boolean "difficulty_breathing"
    t.boolean "fever"
    t.boolean "highest_temp"
    t.integer "days_fever"
    t.boolean "fatigue"
    t.boolean "pain_chest_heart"
    t.boolean "pain_back"
    t.boolean "runny_nose"
    t.boolean "sore_throat"
    t.text "loss_taste_smell"
    t.boolean "diarrhea"
    t.boolean "nauseam"
    t.text "other_symptoms"
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
    t.string "drb1_1"
    t.string "drb1_2"
    t.string "dqb1_1"
    t.string "dqb1_2"
    t.string "dpb1_1"
    t.string "dpb1_2"
    t.string "a_1"
    t.string "a_2"
    t.string "b_1"
    t.string "b_2"
    t.string "c_1"
    t.string "c_2"
    t.string "dpa1_1"
    t.string "dpa1_2"
    t.string "dqa1_1"
    t.string "dqa1_2"
    t.string "drbo_1"
    t.string "drbo_2"
    t.string "drb345_1"
    t.string "drb345_2"
    t.index ["subject_id"], name: "index_hlas_on_subject_id"
  end

  create_table "hospitalizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "icu_admit"
    t.integer "icu_duration_days"
    t.date "start_date"
    t.date "end_date"
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
    t.boolean "hepatits"
    t.boolean "pancreatitis"
    t.boolean "pleural_effusion"
    t.boolean "acute_kidney_failure"
    t.boolean "acute_kidney_chronic"
    t.boolean "ascites"
    t.boolean "dyspnea"
    t.index ["subject_id"], name: "index_hospitalizations_on_subject_id"
  end

  create_table "lab_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "result_date"
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
  end

  create_table "risk_factors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "smoke_100"
    t.text "smoke_freq"
    t.text "alcohol_freq"
    t.text "substances_freq"
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
    t.integer "height"
    t.integer "weight"
    t.boolean "exposed_to_covid19_carrier_20_days"
    t.text "travel_last_20_days"
    t.boolean "medical_worker"
  end

  create_table "treatments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
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
    t.index ["subject_id"], name: "index_treatments_on_subject_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rstudio", default: false
    t.boolean "approved", default: false
    t.text "affiliation"
    t.integer "upload_count", default: 0
    t.boolean "can_upload", default: false
    t.string "rstudio_username"
    t.string "rstudio_password"
    t.boolean "request_rstudio_priv", default: false
    t.boolean "request_upload_priv", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "c19_symptoms", "subjects"
  add_foreign_key "comorbidities", "subjects"
  add_foreign_key "hlas", "subjects"
  add_foreign_key "hospitalizations", "subjects"
  add_foreign_key "risk_factors", "subjects"
  add_foreign_key "treatments", "subjects"
end
