class TreatmentDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "Treatment." },
      # name: { source: "User.name", cond: :like }
      id: { source: "Treatment.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      ace_inhib: { source: "Treatment.ace_inhib" },
      angio_blocker: { source: "Treatment.angio_blocker" },
      antibiotics: { source: "Treatment.antibiotics" },
      antiviral_med: { source: "Treatment.antiviral_med" },
      allergy_med: { source: "Treatment.allergy_med" },
      androgen_med: { source: "Treatment.androgen_med" },
      asthma_med: { source: "Treatment.asthma_med" },
      immunosuppressor_light: { source: "Treatment.immunosuppressor_light" },
      immunosuppressor_strong: { source: "Treatment.immunosuppressor_strong" },
      biologics_mabs: { source: "Treatment.biologics_mabs" },
      nsaid: { source: "Treatment.nsaid" },
      antipytetics: { source: "Treatment.antipytetics" },
      blood_thinner: { source: "Treatment.blood_thinner" },
      vitamin_d_med: { source: "Treatment.vitamin_d_med" },
      vitamin_c_med: { source: "Treatment.vitamin_c_med" },
      med_udca: { source: "Treatment.med_udca" },
      treatment_duration_days: { source: "Treatment.treatment_duration_days" }
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
        ace_inhib: record.ace_inhib,
        angio_blocker: record.angio_blocker,
        antibiotics: record.antibiotics,
        antiviral_med: record.antiviral_med,
        allergy_med: record.allergy_med,
        androgen_med: record.androgen_med,
        asthma_med: record.asthma_med,
        immunosuppressor_light: record.immunosuppressor_light,
        immunosuppressor_strong: record.immunosuppressor_strong,
        biologics_mabs: record.biologics_mabs,
        nsaid: record.nsaid,
        antipytetics: record.antipytetics,
        blood_thinner: record.blood_thinner,
        vitamin_d_med: record.vitamin_d_med,
        vitamin_c_med: record.vitamin_c_med,
        med_udca: record.med_udca,
        treatment_duration_days: record.treatment_duration_days
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    Treatment.where(subject_id:subject_ids)
  end

end
