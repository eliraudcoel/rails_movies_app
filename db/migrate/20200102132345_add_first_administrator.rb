class AddFirstAdministrator < ActiveRecord::Migration[6.0]
  def change
    Administrator.create(email: "admin@example.com", password: "password", first_name: "Admin", last_name: "User")
  end
end
