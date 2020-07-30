class Project < ApplicationRecord
  belongs_to :user
  has_many :subjects, :dependent => :delete_all

  validates :name, uniqueness: { scope: :user_id, message: "A user's projects may not have identical names" }

  after_destroy :wipe_name_from_users_project_list


  def wipe_name_from_users_project_list
    new_list = self.user.project_name - [self.name]
    self.user.update_attributes(project_name:new_list)
  end
end
