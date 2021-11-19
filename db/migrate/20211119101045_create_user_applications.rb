class CreateUserApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_applications do |t|
      t.references :camp, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
