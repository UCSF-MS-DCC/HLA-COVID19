class KirDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "Kir." },
      # name: { source: "User.name", cond: :like }
      id: { source: "Kir.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      k2dl4_1: { source: "Kir.k2dl4_1" },
      k2dl4_2: { source: "Kir.k2dl4_2" },
      k2dl23_1: { source: "Kir.k2dl23_1" },
      k2dl23_2: { source: "Kir.k2dl23_2" },
      k3dl1s1_1: { source: "Kir.k3dl1s1_1" },
      k3dl1s1_2: { source: "Kir.k3dl1s1_2" },
      k3dl2_1: { source: "Kir.k3dl2_1" },
      k3dl2_2: { source: "Kir.k3dl2_2" },
      k3dl3_1: { source: "Kir.k3dl3_1" },
      k3dl3_2: { source: "Kir.k3dl3_2" },
      k2dl1_1: { source: "Kir.k2dl1_1" },
      k2dl1_2: { source: "Kir.k2dl1_2" }
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
        k2dl4_1: record.k2dl4_1,
        k2dl4_2: record.k2dl4_2,
        k2dl23_1: record.k2dl23_1,
        k2dl23_2: record.k2dl23_2,
        k3dl1s1_1: record.k3dl1s1_1,
        k3dl1s1_2: record.k3dl1s1_2,
        k3dl2_1: record.k3dl2_1,
        k3dl2_2: record.k3dl2_2,
        k3dl3_1: record.k3dl3_1,
        k3dl3_2: record.k3dl3_2,
        k2dl1_1: record.k2dl1_1,
        k2dl1_2: record.k2dl1_2
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    Kir.where(subject_id:subject_ids)
  end

end
