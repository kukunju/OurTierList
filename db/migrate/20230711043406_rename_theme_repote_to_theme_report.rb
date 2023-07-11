class RenameThemeRepoteToThemeReport < ActiveRecord::Migration[6.1]
  def change
    rename_table :theme_repotes, :theme_reports
  end
end
