class LabTestDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "LabTest."},
      # name: { source: "User.name", cond: :like }
      id: { source: "LabTest.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      blood_type: { source: "LabTest.blood_type"},
      rh_factor: { source: "LabTest.rh_factor"},
      wbc: { source: "LabTest.wbc"},
      lymphocytes: { source: "LabTest.lymphocytes"},
      neutrophils: { source: "LabTest.neutrophils"},
      monocytes: { source: "LabTest.monocytes"},
      eosinophils: { source: "LabTest.eosinophils"},
      basophils: { source: "LabTest.basophils"},
      crp: { source: "LabTest.crp"},
      trop_i: { source: "LabTest.trop_i"},
      trop_t: { source: "LabTest.trop_t"},
      bnp: { source: "LabTest.bnp"},
      idh: { source: "LabTest.idh"},
      ast: { source: "LabTest.ast"},
      alt: { source: "LabTest.alt"},
      bilirubin: { source: "LabTest.bilirubin"},
      ggt: { source: "LabTest.ggt"},
      alp: { source: "LabTest."},
      d_dimer: { source: "LabTest.alp"},
      il6: { source: "LabTest.il6"},
      tumor_necrosis_factor: { source: "LabTest.tumor_necrosis_factor"},
      serum_femtin: { source: "LabTest.serum_femtin"},
      hba1c: { source: "LabTest.hba1c"},
      cholesterol: { source: "LabTest.cholesterol"},
      triglycerides: { source: "LabTest.triglycerides"},
      hdl: { source: "LabTest.hdl"},
      ldl: { source: "LabTest.ldl"},
      ace: { source: "LabTest.ace"},
      ace2r: { source: "LabTest.ace2r"},
      hemoglobin: { source: "LabTest.hemoglobin"},
      amylase: { source: "LabTest.amylase"},
      lipase: { source: "LabTest.lipase"},
      urea: { source: "LabTest.urea"},
      creatinine: { source: "LabTest.creatinine"}
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
        blood_type: record.blood_type,
        rh_factor: record.rh_factor,
        wbc: record.wbc,
        lymphocytes: record.lymphocytes,
        neutrophils: record.neutrophils,
        monocytes: record.monocytes,
        eosinophils: record.eosinophils,
        basophils: record.basophils,
        crp: record.crp,
        trop_i: record.trop_i,
        trop_t: record.trop_t,
        bnp: record.bnp,
        idh: record.idh,
        ast: record.ast,
        alt: record.alt,
        bilirubin: record.bilirubin,
        ggt: record.ggt,
        alp: record.alp,
        d_dimer: record.d_dimer,
        il6: record.il6,
        tumor_necrosis_factor: record.tumor_necrosis_factor,
        serum_femtin: record.serum_femtin,
        hba1c: record.hba1c,
        cholesterol: record.cholesterol,
        triglycerides: record.triglycerides,
        hdl: record.hdl,
        ldl: record.ldl,
        ace: record.ace,
        ace2r: record.ace2r,
        hemoglobin: record.hemoglobin,
        amylase: record.amylase,
        lipase: record.lipase,
        urea: record.urea,
        creatinine: record.creatinine
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    LabTest.where(subject_id:subject_ids)
  end

end

