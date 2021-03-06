class RiskFactorDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "RiskFactor." },
      # name: { source: "User.name", cond: :like }
      id: { source: "RiskFactor.id" },
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      smoke_freq: { source: "RiskFactor.smoke_freq" },
      alcohol_freq: { source: "RiskFactor.alcohol_freq" },
      substances_freq: { source: "RiskFactor.substances_freq" },
      smoke: { source: "RiskFactor.smoke" }
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
        smoke_freq: record.smoke_freq,
        alcohol_freq: record.alcohol_freq,
        substances_freq: record.substances_freq,
        smoke: record.smoke
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    subject_ids = Subject.where(project_id:options[:project_id]).pluck(:id)
    RiskFactor.where(subject_id:subject_ids)
  end

end

