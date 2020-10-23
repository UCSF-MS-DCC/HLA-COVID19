class UploadRecord < ApplicationRecord
  belongs_to :active_storage_attachment, dependent: :destroy
  require 'tempfile'

  def get_report

  end
end
