class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|

      t.integer :user_id,    null: false
      t.string  :name,       null: false
      t.integer :tier,       null: false
      t.boolean :is_deleted, null: false , default: false

      t.timestamps
    end
  end
end
