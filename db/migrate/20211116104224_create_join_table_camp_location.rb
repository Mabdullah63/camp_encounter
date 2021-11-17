class CreateJoinTableCampLocation < ActiveRecord::Migration[6.1]
  def change
    create_join_table :camps, :locations do |t|
       t.index [:camp_id, :location_id]
       t.index [:location_id, :camp_id]
    end
  end
end
