class AddSubjectRefToLabTests < ActiveRecord::Migration[5.2]
  def change
    add_reference :lab_tests, :subject, index: true
  end
end
