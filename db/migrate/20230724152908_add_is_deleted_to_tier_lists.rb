class AddIsDeletedToTierLists < ActiveRecord::Migration[6.1]
  def change
    add_column :tier_lists, :is_deleted, :boolean, default: false, null: false
  end
end
