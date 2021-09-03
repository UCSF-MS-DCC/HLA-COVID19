class CreatePublicationSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :publication_subjects do |t|
      t.references :publication, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
