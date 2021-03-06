class SubjectDatatable < AjaxDatatablesRails::ActiveRecord
  
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      hlac19_id: { source: "Subject.hlac19_id" },
      origin_identifier: { source: "Subject.origin_identifier" },
      sex: { source: "Subject.sex" },
      gender: { source: "Subject.gender" },
      education: { source: "Subject.education" },
      age: { source: "Subject.age" },
      ethnicity: { source: "Subject.ethnicity" },
      pregnant: { source: "Subject.pregnant" },
      ancestry: { source: "Subject.ancestry" },
      height_cm: { source: "Subject.height_cm" },
      weight_kg: { source: "Subject.weight_kg" },
      race: { source: "Subject.race" },
      country_of_residence: { source: "Subject.country_of_residence" },
      vaccinated: { source: "Subject.vaccinated" },
      vaccine_type: { source: "Subject.vaccine_type" }
    }
  end

  def data
    records.map do |record|
      {
        # example:
        # id: record.id,
        # name: record.name
        hlac19_id: record.hlac19_id,
        origin_identifier: record.origin_identifier,
        sex: record.sex,
        gender: record.gender,
        education: record.education,
        age: record.age,
        ethnicity: record.ethnicity,
        pregnant: record.pregnant,
        ancestry: record.ancestry,
        height_cm: record.height_cm,
        weight_kg: record.weight_kg,
        race: record.race,
        country_of_residence: record.country_of_residence,
        vaccinated: record.vaccinated,
        vaccine_type: record.vaccine_type
      }
    end
  end

  def get_raw_records
    Subject.where(project_id:options[:project_id])
    # insert query here
    # User.all
  end

end

