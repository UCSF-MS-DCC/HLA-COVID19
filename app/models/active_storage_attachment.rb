class ActiveStorageAttachment < ApplicationRecord
    has_one :upload_record, :dependent => :destroy
    has_paper_trail
end
