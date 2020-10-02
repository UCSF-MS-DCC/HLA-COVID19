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

  def get_hla
    CSV.generate do |csv|
        sub_col_heads = ["origin_identifier", "hlac19_id"]
        hla_col_heads = Hla.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(hla_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        hlas = Hla.where(subject_id:subjects_ids)
        csv << full_col_heads
        hlas.each do |h|
            sub_vals = h.subject.attributes.values_at(*["origin_identifier", "hlac19_id"])
            hla_vals = h.attributes.values_at(*hla_col_heads)
            row = sub_vals.concat(hla_vals)
            csv << row
        end
    end
  end
  def get_stats
    CSV.generate do |csv|
        sub_col_heads = ["origin_identifier", "hlac19_id"]
        stat_col_heads = Imputationstat.column_names.reject{ |cn| ["id", "hla_id", "created_at", "updated_at"].include? cn }.map{ |cn| cn.to_s }
        full_col_heads = sub_col_heads.concat(stat_col_heads)
        subjects_ids = self.subjects.pluck(:id)
        hlas = Hla.where(subject_id:subjects_ids)
        csv << full_col_heads
        hlas.each do |h|
            sub_vals = h.subject.attributes.values_at(*["origin_identifier", "hlac19_id"])
            stat_vals = h.imputationstat.attributes.values_at(*stat_col_heads)
            row = sub_vals.concat(stat_vals)
            csv << row
        end
    end
  end
end
