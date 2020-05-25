class RemoveColsFromWeeklyC19Surveys < ActiveRecord::Migration[5.2]
  def change
    remove_column :weekly_c19_surveys, :wait_for_results
  end
end
