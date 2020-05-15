class CreateWeeklyC19Surveys < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_c19_surveys do |t|
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
