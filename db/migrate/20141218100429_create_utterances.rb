class CreateUtterances < ActiveRecord::Migration
  def change
    create_table :utterances do |t|
      t.references :chat, index: true
      t.string :type, null: false
      t.text :text
      t.timestamps null: false
    end
    add_foreign_key :utterances, :chats
  end
end
