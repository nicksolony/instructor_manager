class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name, unique: true
      t.string :email, unique: true
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :phone
    end
  end
end
