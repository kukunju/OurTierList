class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      
      t.integer :user_id,      null: false
      t.integer :tier_list_id, null: false
      t.text    :comment,      null: false
      t.boolean :is_deleted,   null: false , default: false

      t.timestamps
    end
  end
end
