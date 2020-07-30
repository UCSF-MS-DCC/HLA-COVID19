class UploadRecord < ApplicationRecord
  belongs_to :active_storage_attachment
  require 'tempfile'

  def get_report

  end
end
