class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :user
      t.string :key
      t.timestamps null: false
    end
    add_index :chats, :key, unique: true
  end
end
