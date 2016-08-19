class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :memos, [:user_id, :created_at]
  end
end
