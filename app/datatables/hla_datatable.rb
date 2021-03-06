class HlaDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      id: { source: "Hla.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      drb1_1: { source: "Hla.drb1_1" },
      drb1_2: { source: "Hla.drb1_2" },
      dqb1_1: { source: "Hla.dqb1_1" },
      dqb1_2: { source: "Hla.dqb1_2" },
      dpb1_1: { source: "Hla.dpb1_1" },
      dpb1_2: { source: "Hla.dpb1_2" },
      a_1: { source: "Hla.a_1" },
      a_2: { source: "Hla.a_2" },
      b_1: { source: "Hla.b_1" },
      b_2: { source: "Hla.b_2" },
      c_1: { source: "Hla.c_1" },
      c_2: { source: "Hla.c_2" },
      dpa1_1: { source: "Hla.dpa1_1" },
      dpa1_2: { source: "Hla.dpa1_2" },
      dqa1_1: { source: "Hla.dqa1_1" },
      dqa1_2: { source: "Hla.dqa1_2" },
      drbo_1: { source: "Hla.drbo_1" },
      drbo_2: { source: "Hla.drbo_2" },
      drb345_1: { source: "Hla.drb345_1" },
      drb345_2: { source: "Hla.drb345_2" },
      reference_database: { source: "Hla.reference_database" },
      reference_database_version: { source: "Hla.reference_database_version" },
      typing_method_name: { source: "Hla.typing_method_name" },
      typing_method_version: { source: "Hla.typing_method_version" },
      gl_string: { source: "Hla.gl_string" },
      novel_polymorphisms: { source: "Hla.novel_polymorphisms" },
      pop: { source: "Hla.pop" }
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
        drb1_1: record.drb1_1,
        drb1_2: record.drb1_2,
        dqb1_1: record.dqb1_1,
        dqb1_2: record.dqb1_2,
        dpb1_1: record.dpb1_1,
        dpb1_2: record.dpb1_2,
        a_1: record.a_1,
        a_2: record.a_2,
        b_1: record.b_1,
        b_2: record.b_2,
        c_1: record.c_1,
        c_2: record.c_2,
        dpa1_1: record.dpa1_1,
        dpa1_2: record.dpa1_2,
        dqa1_1: record.dqa1_1,
        dqa1_2: record.dqa1_2,
        drbo_1: record.drbo_1,
        drbo_2: record.drbo_2,
        drb345_1: record.drb345_1,
        drb345_2: record.drb345_2,
        reference_database: record.reference_database,
        reference_database_version: record.reference_database_version,
        typing_method_name: record.typing_method_name,
        typing_method_version: record.typing_method_version,
        gl_string: record.gl_string,
        novel_polymorphisms: record.novel_polymorphisms,
        pop: record.pop
      }
    end
  end

  def get_raw_records
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    Hla.where(subject_id:subject_ids)
    # insert query here
    # User.all
  end

end

