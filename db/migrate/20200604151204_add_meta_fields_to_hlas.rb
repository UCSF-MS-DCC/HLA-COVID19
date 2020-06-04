class AddMetaFieldsToHlas < ActiveRecord::Migration[5.2]
  def change
    add_column :hlas, :reference_database, :text
    add_column :hlas, :reference_database_version, :text
    add_column :hlas, :typing_method_name, :text
    add_column :hlas, :typing_method_version, :text
    add_column :hlas, :gl_string, :text
    add_column :hlas, :novel_polymorphisms, :text
  end
end
