class HospitalizationDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "Hospitalization." }, cond: :eq },
      # name: { source: "User.name", cond: :like }
      id: { source: "Hospitalization.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      icu_admit: { source: "Hospitalization.icu_admit" },
      icu_duration_days: { source: "Hospitalization.icu_duration_days" },
      reason_hosp_ended: { source: "Hospitalization.reason_hosp_ended" },
      septic_shock: { source: "Hospitalization.septic_shock" },
      days_after_c19_septic_shock: { source: "Hospitalization.days_after_c19_septic_shock" },
      organ_failure: { source: "Hospitalization.organ_failure" },
      resp_failure: { source: "Hospitalization.resp_failure" },
      resp_rate_intake: { source: "Hospitalization.resp_rate_intake" },
      resp_breath_per_min: { source: "Hospitalization.resp_breath_per_min" },
      blood_o2_sat: { source: "Hospitalization.blood_o2_sat" },
      highest_resp_support: { source: "Hospitalization.highest_resp_support" },
      days_ventilator: { source: "Hospitalization.days_ventilator" },
      pa02_min: { source: "Hospitalization.pa02_min" },
      fio2_max: { source: "Hospitalization.fio2_max" },
      lung_infiltrates: { source: "Hospitalization.lung_infiltrates" },
      pneumonia: { source: "Hospitalization.pneumonia" },
      pneumonia_days_after_c19_symptoms: { source: "Hospitalization.pneumonia_days_after_c19_symptoms" },
      ef_echo: { source: "Hospitalization.ef_echo" },
      hepatitis: { source: "Hospitalization.hepatitis" },
      pancreatitis: { source: "Hospitalization.pancreatitis" },
      pleural_effusion: { source: "Hospitalization.pleural_effusion" },
      acute_kidney_failure: { source: "Hospitalization.acute_kidney_failure" },
      acute_kidney_chronic: { source: "Hospitalization.acute_kidney_chronic" },
      ascites: { source: "Hospitalization.ascites" },
      dyspnea: { source: "Hospitalization.dyspnea" },
      hospitalization_duration_days: { source: "Hospitalization.hospitalization_duration_days" },
      hospitalization_admit: { source: "Hospitalization.hospitalization_admit" }
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
        icu_admit: record.icu_admit,
        icu_duration_days: record.icu_duration_days,
        reason_hosp_ended: record.reason_hosp_ended,
        septic_shock: record.septic_shock,
        days_after_c19_septic_shock: record.days_after_c19_septic_shock,
        organ_failure: record.organ_failure,
        resp_failure: record.resp_failure,
        resp_rate_intake: record.resp_rate_intake,
        resp_breath_per_min: record.resp_breath_per_min,
        blood_o2_sat: record.blood_o2_sat,
        highest_resp_support: record.highest_resp_support,
        days_ventilator: record.days_ventilator,
        pa02_min: record.pa02_min,
        fio2_max: record.fio2_max,
        lung_infiltrates: record.lung_infiltrates,
        pneumonia: record.pneumonia,
        pneumonia_days_after_c19_symptoms: record.pneumonia_days_after_c19_symptoms,
        ef_echo: record.ef_echo,
        hepatitis: record.hepatitis,
        pancreatitis: record.pancreatitis,
        pleural_effusion: record.pleural_effusion,
        acute_kidney_failure: record.acute_kidney_failure,
        acute_kidney_chronic: record.acute_kidney_chronic,
        ascites: record.ascites,
        dyspnea: record.dyspnea,
        hospitalization_duration_days: record.hospitalization_duration_days,
        hospitalization_admit: record.hospitalization_admit
      }
    end
  end

  def get_raw_records
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    Hospitalization.where(subject_id:subject_ids)
    # insert query here
    # User.all
  end

end
