class AddJobToChat < ActiveRecord::Migration
  def change
    change_table :chats do |t|
      t.references :job, index: true
    end
    add_foreign_key :chats, :jobs
  end
end
