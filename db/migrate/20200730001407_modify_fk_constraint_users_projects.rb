class ModifyFkConstraintUsersProjects < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:projects, :users)
      remove_foreign_key(:projects, :users)
      add_foreign_key :projects, :users, on_delete: :cascade
    end
  end
end
