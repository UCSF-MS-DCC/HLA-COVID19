class C19SymptomDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
       id: { source: "C19Symptom.id" },
       hlac19_id: { source: "Subject.hlac19_id" },
       origin_identifier: { source: "Subject.origin_identifier" },
       dry_cough: { source: "C19Symptom.dry_cough" },
       mucus_cough: { source: "C19Symptom.mucus_cough" },
       days_cough: { source: "C19Symptom.days_cough" },
       difficulty_breathing: { source: "C19Symptom.difficulty_breathing" },
       fever: { source: "C19Symptom.fever" },
       highest_temp: { source: "C19Symptom.highest_temp" },
       days_fever: { source: "C19Symptom.days_fever" },
       fatigue: { source: "C19Symptom.fatigue" },
       pain_chest_heart: { source: "C19Symptom.pain_chest_heart" },
       pain_back: { source: "C19Symptom.pain_back" },
       runny_nose: { source: "C19Symptom.runny_nose" },
       sore_throat: { source: "C19Symptom.sore_throat" },
       loss_taste_smell: { source: "C19Symptom.loss_taste_smell" },
       diarrhea: { source: "C19Symptom.diarrhea" },
       nausea: { source: "C19Symptom.nausea" },
       other_symptoms: { source: "C19Symptom.other_symptoms" },
       c19_test_result_positive: { source: "C19Symptom.c19_test_result_positive" },
       type_of_c19_test: { source: "C19Symptom.type_of_c19_test" }
    }
  end

  def data
    records.map do |record|
      hla_id = record.subject.hlac19_id
      org_id = record.subject.origin_identifier
      {
        # example:
        # id: record.id,
        # name: record.name
        id: record.id,
        hlac19_id: hla_id,
        origin_identifier: org_id,
        dry_cough:  record.dry_cough,
        mucus_cough: record.mucus_cough,
        days_cough: record.days_cough,
        difficulty_breathing: record.difficulty_breathing,
        fever: record.fever,
        highest_temp: record.highest_temp,
        days_fever: record.days_fever,
        fatigue: record.fatigue,
        pain_chest_heart: record.pain_chest_heart,
        pain_back: record.pain_back,
        runny_nose: record.runny_nose,
        sore_throat: record.sore_throat,
        loss_taste_smell: record.loss_taste_smell,
        diarrhea: record.diarrhea,
        nausea: record.nausea,
        other_symptoms: record.other_symptoms,
        c19_test_result_positive: record.c19_test_result_positive,
        type_of_c19_test: record.type_of_c19_test
      }
    end
  end

  def get_raw_records
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    C19Symptom.where(subject_id:subject_ids)
    # insert query here
    # User.all
  end

end
