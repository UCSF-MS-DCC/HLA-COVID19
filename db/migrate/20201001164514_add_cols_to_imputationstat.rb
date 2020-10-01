class AddColsToImputationstat < ActiveRecord::Migration[5.2]
  def change
    add_column :imputationstats, :a_prob, :string
    add_column :imputationstats, :a_matching, :string
    add_column :imputationstats, :b_prob, :string
    add_column :imputationstats, :b_matching, :string
    add_column :imputationstats, :c_prob, :string
    add_column :imputationstats, :c_matching, :string
    add_column :imputationstats, :drb1_prob, :string
    add_column :imputationstats, :drb1_matching, :string
    add_column :imputationstats, :dqa1_prob, :string
    add_column :imputationstats, :dqa1_matching, :string
    add_column :imputationstats, :dqb1_prob, :string
    add_column :imputationstats, :dqb1_matching, :string
    add_column :imputationstats, :dpb1_prob, :string
    add_column :imputationstats, :dpb1_matching, :string
    add_column :imputationstats, :dpb1_1, :string
    add_column :imputationstats, :dpb1_2, :string
    add_column :imputationstats, :typing_method_name, :string
    add_column :imputationstats, :typing_method_version, :string
    add_column :imputationstats, :population, :string
  end
end
