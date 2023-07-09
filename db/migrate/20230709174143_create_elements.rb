class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|

      t.integer :theme_id, null: false
      t.string  :name,     null: false

      t.timestamps
    end
  end
end
