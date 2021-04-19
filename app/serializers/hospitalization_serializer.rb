class HospitalizationSerializer < ActiveModel::Serializer
  attribute :hlac19_id
  attribute :project
  attributes Hospitalization.column_names.reject{ |c| ["id", "created_at", "updated_at", "subject_id"].include? c }

  def hlac19_id
    Subject.find(object.subject_id).hlac19_id
  end

  def project
    Subject.find(object.subject_id).project.name
  end
end
