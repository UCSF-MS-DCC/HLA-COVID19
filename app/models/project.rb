class Project < ApplicationRecord
  belongs_to :user
  has_many :subjects, :dependent => :delete_all
  has_paper_trail
  require 'csv'

  validates :name, uniqueness: { scope: :user_id, message: "A user's projects may not have identical names" }

  after_destroy :wipe_name_from_users_project_list


  def wipe_name_from_users_project_list
    new_list = self.user.project_name - [self.name]
    self.user.update_attributes(project_name:new_list)
  end
  def get_subjects
    CSV.generate do |csv|
        sub_col_heads = Subject.column_names.reject{ |cn| ["id", "project_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        subjects_ids = self.subjects.pluck(:id)
        hlas = Hla.where(subject_id:subjects_ids)
        csv << sub_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*sub_col_heads)
            csv << sub_vals
        end
    end
  end
  def get_hla
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        hla_col_heads = Hla.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(hla_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        hlas = Hla.where(subject_id:subjects_ids)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            hla_vals = Hla.find_by(subject_id:sid) ? Hla.find_by(subject_id:sid).attributes.values_at(*hla_col_heads) : nil
            row = (hla_vals.nil?) ? sub_vals : sub_vals.concat(hla_vals)
            csv << row
        end
    end
  end
  def get_stats
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        stat_col_heads = Imputationstat.column_names.reject{ |cn| ["id", "hla_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(stat_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        hlas = Hla.where(subject_id:subjects_ids)
        csv << full_col_heads
        hlas.each do |h|
            sub_vals = h.subject.attributes.values_at(*["hlac19_id", "origin_identifier"])
            stat_vals = h.imputationstat.attributes.values_at(*stat_col_heads)
            row = sub_vals.concat(stat_vals)
            csv << row
        end
    end
  end
  def get_comorbidities
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        comorb_col_heads = Comorbidity.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(comorb_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            comorb_vals = Comorbidity.find_by(subject_id:sid) ? Comorbidity.find_by(subject_id:sid).attributes.values_at(*comorb_col_heads) : nil
            row = (comorb_vals.nil?) ? sub_vals : sub_vals.concat(comorb_vals)
            csv << row
        end
    end
  end  
  def get_symptoms
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        c19_col_heads = C19Symptom.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(c19_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            c19_vals = C19Symptom.find_by(subject_id:sid) ? C19Symptom.find_by(subject_id:sid).attributes.values_at(*c19_col_heads) : nil
            row = (c19_vals.nil?) ? sub_vals : sub_vals.concat(c19_vals)
            csv << row
        end
    end
  end
  def get_hospitalizations
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        hosp_col_heads = Hospitalization.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(hosp_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            hosp_vals = Hospitalization.find_by(subject_id:sid) ? Hospitalization.find_by(subject_id:sid).attributes.values_at(*hosp_col_heads) :nil
            row = (hosp_vals.nil?) ? sub_vals : sub_vals.concat(hosp_vals)
            csv << row
        end
    end
  end
  def get_lab_tests
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        lb_col_heads = LabTest.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(lb_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            lb_vals = LabTest.find_by(subject_id:sid) ? LabTest.find_by(subject_id:sid).attributes.values_at(*lb_col_heads) : nil
            row = (lb_vals.nil?) ? sub_vals : sub_vals.concat(lb_vals)
            csv << row
        end
    end
  end
  def get_risk_factors
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        rf_col_heads = RiskFactor.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(rf_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            rf_vals = RiskFactor.find_by(subject_id:sid) ? RiskFactor.find_by(subject_id:sid).attributes.values_at(*rf_col_heads) : nil
            row = (rf_vals.nil?) ? sub_vals : sub_vals.concat(rf_vals)
            csv << row
        end
    end
  end
  def get_treatments
    CSV.generate do |csv|
        sub_col_heads = ["hlac19_id", "origin_identifier"]
        tmt_col_heads = Treatment.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(tmt_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        tmts = Treatment.where(subject_id:subjects_ids)
        csv << full_col_heads
        subjects_ids.each do |sid|
            sub_vals = Subject.find(sid).attributes.values_at(*["hlac19_id", "origin_identifier"])
            tmt_vals = Treatment.find_by(subject_id:sid) ? Treatment.find_by(subject_id:sid).attributes.values_at(*tmt_col_heads) : nil
            row = (tmt_vals.nil?) ? sub_vals : sub_vals.concat(tmt_vals)
            csv << row
        end
    end
  end


end
