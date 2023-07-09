class CreateSelectedElements < ActiveRecord::Migration[6.1]
  def change
    create_table :selected_elements do |t|

      t.integer :tier_list_id, null: false
      t.integer :element_id,   null: false
      t.integer :tier,         null: false

      t.timestamps
    end
  end
end
