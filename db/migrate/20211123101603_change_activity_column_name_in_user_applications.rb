class ChangeActivityColumnNameInUserApplications < ActiveRecord::Migration[6.1]
  def change
    rename_column(:user_applications, :activity, :Dinner)
  end
end
