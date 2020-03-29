class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :phone
    end
  end
end
