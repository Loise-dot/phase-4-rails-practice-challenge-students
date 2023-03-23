class CreateInstructors < ActiveRecord::Migration[6.1]
  def change
    create_table :instructors do |t|

      t.timestamps
    end
  end
end
