class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable
  #after_create :send_new_account_notification
  validates_uniqueness_of :email
  has_many_attached :uploads

  before_create :set_default_approved_access

  serialize :project_owner, Array
  serialize :approved_access, Array
  
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

  def set_default_approved_access 
    self.approved_access = ["general"]
  end
end
