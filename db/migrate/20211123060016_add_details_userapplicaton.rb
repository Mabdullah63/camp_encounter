class AddDetailsUserapplicaton < ActiveRecord::Migration[6.1]
  def change
    add_column :user_applications, :age, :integer
    add_column :user_applications, :gender, :string
    add_column :user_applications, :lunch, :boolean
    add_column :user_applications, :insurance, :string
    add_column :user_applications, :food_options, :string
    add_column :user_applications, :dinner, :string
    add_column :user_applications, :medical_history, :string
    add_column :user_applications, :wifi_service, :boolean
    add_column :user_applications, :address, :string
    add_column :user_applications, :emergency_contact, :string
    add_column :user_applications, :shirt_size, :string
    add_column :user_applications, :progress_bar, :integer, default: 0
  end
end
