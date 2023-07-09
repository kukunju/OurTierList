class CreateThemeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_tags do |t|

      t.integer :theme_id, null: false
      t.integer :tag_id,   null: false

      t.timestamps
    end
  end
end
