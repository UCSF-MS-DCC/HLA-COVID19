class CreateUploadRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :upload_records do |t|
      t.references :active_storage_attachment, foreign_key: true

      t.timestamps
    end
  end
end
