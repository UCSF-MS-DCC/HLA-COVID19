class ActiveStorageAttachment < ApplicationRecord
    has_one :upload_record
    has_paper_trail
end
