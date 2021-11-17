class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.string :type

      t.timestamps
    end
  end
end
