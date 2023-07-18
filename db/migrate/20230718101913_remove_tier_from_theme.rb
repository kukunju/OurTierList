class RemoveTierFromTheme < ActiveRecord::Migration[6.1]
  def change
    remove_column :themes, :tier, :integer
  end
end
