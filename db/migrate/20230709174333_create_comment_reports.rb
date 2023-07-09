class CreateCommentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_reports do |t|

      t.integer :user_id,    null: false
      t.integer :comment_id, null: false
      t.string  :reason,     null: false
      t.boolean :is_solved,  null: false

      t.timestamps
    end
  end
end
