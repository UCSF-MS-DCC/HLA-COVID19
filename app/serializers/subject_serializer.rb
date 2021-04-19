class SubjectSerializer < ActiveModel::Serializer

  attributes Subject.column_names.reject{ |c| ["id", "created_at", "updated_at"].include? c }
  attribute :project

  def project
    Subject.find(object.id).project.name
  end

  def include_hla?
    puts @instance_options
    false
  end
  def hla
    if @instance_options[:hla] == true
      @atts = object.hla.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @hla_aliases = Hla.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@hla_aliases[k] || k] = v }
      @atts
    else
      "not requested"
    end
  end

  def c19_symptom
    if @instance_options[:c19_symptoms] == true
      @atts = object.c19_symptom.first.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @c19_aliases = C19Symptom.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@c19_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
  def comorbidity
    if @instance_options[:comorbidity] == true
      @atts = object.comorbidity.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @com_aliases = Comorbidity.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@com_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
  def hospitalization
    if @instance_options[:hospitalization] == true
      @atts = object.hospitalization.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @hosp_aliases = Hospitalization.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@hosp_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
  def lab_test
    if @instance_options[:lab_test] == true
      @atts = object.lab_test.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @lt_aliases = LabTest.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@lt_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
  def risk_factor
    if @instance_options[:risk_factor] == true
      @atts = object.risk_factor.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @rf_aliases = RiskFactor.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@rf_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
  def treatment
    if @instance_options[:treatment] == true
      @atts = object.treatment.attributes.reject{ |c| ["id", "subject_id", "created_at", "updated_at"].include? c }
      @tmt_aliases = Treatment.attribute_aliases.invert
      @atts.each_with_object({}) { |(k, v), memo| memo[@tmt_aliases[k] || k] = v }
    else
      "not requested"
    end
  end
end
