class RenameColumnTypeOfCamp < ActiveRecord::Migration[6.1]
  def change
    rename_column(:camps, :type, :camp_type)
  end
end
