class ComorbidityDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      id: { source: "Comorbidity.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      hiv: { source: "Comorbidity.hiv" },
      cd4_cell_count: { source: "Comorbidity.cd4_cell_count" },
      hiv_load: { source: "Comorbidity.hiv_load" },
      immunocompromised: { source: "Comorbidity.immunocompromised" },
      organ_transplant: { source: "Comorbidity.organ_transplant" },
      organ_transplant_type: { source: "Comorbidity.organ_transplant_type" },
      bone_marrow_transplant: { source: "Comorbidity.bone_marrow_transplant" },
      autoimmune_rheum_disease: { source: "Comorbidity.autoimmune_rheum_disease" },
      diabetes_type_1: { source: "Comorbidity.diabetes_type_1" },
      diabetes_type_2: { source: "Comorbidity.diabetes_type_2" },
      asthma: { source: "Comorbidity.asthma" },
      copd: { source: "Comorbidity.copd" },
      cystic_fib: { source: "Comorbidity.cystic_fib" },
      liver_disease: { source: "Comorbidity.liver_disease" },
      gallbladder_disease: { source: "Comorbidity.gallbladder_disease" },
      pancreas_disease: { source: "Comorbidity.pancreas_disease" },
      angio_coronary_intervention: { source: "Comorbidity.angio_coronary_intervention" },
      artery_bypass: { source: "Comorbidity.artery_bypass" },
      cong_heart_failure: { source: "Comorbidity.cong_heart_failure" },
      hypertension: { source: "Comorbidity.hypertension" },
      infarction_type_1: { source: "Comorbidity.infarction_type_1" },
      infarction_type_2: { source: "Comorbidity.infarction_type_2" },
      peri_vascular_dis: { source: "Comorbidity.peri_vascular_dis" },
      stroke: { source: "Comorbidity.stroke" },
      arythmia: { source: "Comorbidity.arythmia" },
      dementia: { source: "Comorbidity.dementia" },
      neur_disease: { source: "Comorbidity.neur_disease" },
      leukemia: { source: "Comorbidity.leukemia" },
      lymphoma: { source: "Comorbidity.lymphoma" },
      malignant_solid_tumor: { source: "Comorbidity.malignant_solid_tumor" }
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
        hiv: record.hiv,
        cd4_cell_count: record.cd4_cell_count,
        hiv_load: record.hiv_load,
        immunocompromised: record.immunocompromised,
        organ_transplant: record.organ_transplant,
        organ_transplant_type: record.organ_transplant_type,
        bone_marrow_transplant: record.bone_marrow_transplant,
        autoimmune_rheum_disease: record.autoimmune_rheum_disease,
        diabetes_type_1: record.diabetes_type_1,
        diabetes_type_2: record.diabetes_type_2,
        asthma: record.asthma,
        copd: record.copd,
        cystic_fib: record.cystic_fib,
        liver_disease: record.liver_disease,
        gallbladder_disease: record.gallbladder_disease,
        pancreas_disease: record.pancreas_disease,
        angio_coronary_intervention: record.angio_coronary_intervention,
        artery_bypass: record.artery_bypass,
        cong_heart_failure: record.cong_heart_failure,
        hypertension: record.hypertension,
        infarction_type_1: record.infarction_type_1,
        infarction_type_2: record.infarction_type_2,
        peri_vascular_dis: record.peri_vascular_dis,
        stroke: record.stroke,
        arythmia: record.arythmia,
        dementia: record.dementia,
        neur_disease: record.neur_disease,
        leukemia: record.leukemia,
        lymphoma: record.lymphoma,
        malignant_solid_tumor: record.malignant_solid_tumor
      }
    end
  end

  def get_raw_records
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    Comorbidity.where(subject_id:subject_ids)
    # insert query here
    # User.all
  end

end
=begin
["id",
 "subject_id",
 "created_at",
 "updated_at",
 "hiv",
 "cd4_cell_count",
 "hiv_load",
 "immunocompromised",
 "organ_transplant",
 "organ_transplant_type",
 "bone_marrow_transplant",
 "autoimmune_rheum_disease",
 "diabetes_type_1",
 "diabetes_type_2",
 "asthma",
 "copd",
 "cystic_fib",
 "liver_disease",
 "gallbladder_disease",
 "pancreas_disease",
 "angio_coronary_intervention",
 "artery_bypass",
 "cong_heart_failure",
 "hypertension",
 "infarction_type_1",
 "infarction_type_2",
 "peri_vascular_dis",
 "stroke",
 "arythmia",
 "dementia",
 "neur_disease",
 "leukemia",
 "lymphoma",
 "malignant_solid_tumor"]
=end