class CreateThemeRepotes < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_repotes do |t|

      t.integer :user_id,  null: false
      t.integer :theme_id, null: false
      t.string  :reason,   null: false
      t.boolean :is_solved,null: false, default: false

      t.timestamps
    end
  end
end
