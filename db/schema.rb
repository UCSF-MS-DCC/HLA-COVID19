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

ActiveRecord::Schema.define(version: 2020_05_27_184031) do

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

  create_table "anxieties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_anxieties_on_subject_id"
  end

  create_table "baseline_c19_surveys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "coronavirus_tested"
    t.string "coronavirus_test_result"
    t.boolean "hospitalized"
    t.boolean "respirator"
    t.text "c19_symptons"
    t.index ["subject_id"], name: "index_baseline_c19_surveys_on_subject_id"
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

  create_table "families", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_families_on_subject_id"
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

  create_table "medical_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_medical_histories_on_subject_id"
  end

  create_table "smoking_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_smoking_histories_on_subject_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hlac19_id"
    t.string "origin_identifier"
    t.string "country_of_residence"
    t.string "zip_code"
    t.string "field_employment"
    t.text "sex"
    t.text "gender"
    t.text "gender_identity"
    t.boolean "asian"
    t.boolean "pacific_islander"
    t.boolean "hispanic"
    t.boolean "african_american"
    t.boolean "white"
    t.boolean "education"
    t.integer "age"
    t.text "ethnicity"
    t.boolean "pregnant"
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

  create_table "weekly_c19_surveys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tested_past_week"
    t.text "test_result"
    t.boolean "hospitalized"
    t.boolean "respirator"
    t.text "c19_symptons"
    t.index ["subject_id"], name: "index_weekly_c19_surveys_on_subject_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "anxieties", "subjects"
  add_foreign_key "baseline_c19_surveys", "subjects"
  add_foreign_key "comorbidities", "subjects"
  add_foreign_key "families", "subjects"
  add_foreign_key "hlas", "subjects"
  add_foreign_key "hospitalizations", "subjects"
  add_foreign_key "medical_histories", "subjects"
  add_foreign_key "smoking_histories", "subjects"
  add_foreign_key "weekly_c19_surveys", "subjects"
end
