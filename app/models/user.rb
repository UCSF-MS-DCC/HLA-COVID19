class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable
  #after_create :send_new_account_notification
  validates_uniqueness_of :email
  has_many_attached :uploads
  has_many :projects, :dependent => :delete_all
  validates :uploads, blob: { content_type: 'text/csv' }
  accepts_nested_attributes_for :projects
  after_create :make_projects
  after_update :make_projects

  after_update :upload_filename_check

  serialize :approved_access, Array
  serialize :project_name, Array
  
  def make_projects
    if self.project_owner == true && self.project_name.count > 0
      self.project_name.each do |pname|
        puts pname
        unless self.projects.where(name:pname).count >= 1
          @project = Project.new(user_id:self.id, name:pname)
          @project.save
          self.update_attributes(approved_access:self.approved_access.concat([@project.id]))
        end
      end
    end
  end

  def make_additional_project
  end


  def send_new_account_notification
    AdminMailer.new_user_waiting_for_approval(email).deliver
    AdminMailer.new_user_notice(email).deliver
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure_not_approved")
    elsif recoverable.approved?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved ? super : :not_approved
  end

  def upload_filename_check
    self.uploads.each do |u|
      unless u.filename.to_s.match(/^'#{self.rstudio_username}'/)
        puts "NO MATCH: #{u.filename}"
        u.update(filename:"#{self.rstudio_username}_#{u.filename}")
        puts "UPDATED: #{u.filename}"
        system("pwd")
      end
    end
  end
end
