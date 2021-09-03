class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :timeoutable
  after_create :send_new_account_notification
  validates_uniqueness_of :email
  validates_uniqueness_of :rstudio_username, allow_nil: :true
  has_many_attached :uploads
  has_many :projects, :dependent => :delete_all
  validates :uploads, blob: { content_type: 'text/csv' }
  accepts_nested_attributes_for :projects
  after_create :make_projects
  after_update :make_projects
  after_update :complete_account_approval, if: :approved_and_not_notified?
  after_create :send_welcome_email
  after_create :send_new_user_admin_notification
  has_paper_trail

  after_update :upload_filename_check

  serialize :approved_access, Array
  serialize :project_name, Array
  serialize :grant_project_access_to, Array 
  
  def approved_and_not_notified?
    self.approved && !self.notified_of_approval
  end
  def complete_account_approval
  # Commented code designed to automate creation of server accounts. Now this will be done manually until a robust way to automate is found.   
  #   rstudio_u = self.email.split("@")[0]
  #   rstudio_p = SecureRandom.alphanumeric(12)
  #   if self.update_attributes(notified_of_approval:true, project_owner:true, can_upload:true, rstudio:true, rstudio_username:rstudio_u, rstudio_password:rstudio_p)
  #     # use the system() command to create a server account with home dir and password. Email the admin 
  #     if system("sudo useradd -m -p $(openssl passwd -1 #{rstudio_p}) #{rstudio_u}") #<- create user with password and home directory
  #       AdminMailer.notify_admin_of_server_account_creation(self, true)
  #       AdminMailer.user_approved_notification(self)
  #     else
  #       AdminMailer.notify_admin_of_server_account_creation(self, false)
  #     end
  #   else 
  #     AdminMailer.notify_admin_of_server_account_creation(self, false)
  #   end
  # end
    rstudio_u = self.email.split("@")[0]
    rstudio_p = SecureRandom.alphanumeric(12)
    if self.update_attributes(notified_of_approval:true, project_owner:true, can_upload:true, rstudio:true, rstudio_username:rstudio_u, rstudio_password:rstudio_p)
      AdminMailer.notify_admin_of_server_account_creation(self, true)
      AdminMailer.user_approved_notification(self)
    else 
      AdminMailer.notify_admin_of_server_account_creation(self, false)
    end
  end

  def create_server_account
    puts "Inside create_server_account #{self.email.split("@")[0]}"
  end
  
  def make_projects
    if self.project_owner == true && self.project_name.count > 0
      self.project_name.each do |pname|
        puts pname
        unless self.projects.where(name:pname).count >= 1
          @project = Project.new(user_id:self.id, name:pname)
          @project.save
          self.update_attributes(approved_access:self.approved_access.concat([@project.id]), grant_project_access_to:self.grant_project_access_to.concat([@project.id]))
        end
      end
    end
  end

  def admin?
    self.admin_access == true
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

  def send_welcome_email
    AdminMailer.new_user_welcome_message(self).deliver
  end

  def send_new_user_admin_notification
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end
end
