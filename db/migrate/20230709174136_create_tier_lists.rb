class CreateTierLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tier_lists do |t|
      
      t.integer :theme_id, null: false
      t.integer :user_id,  null: false
      t.text    :comment,  null: false

      t.timestamps
    end
  end
end
