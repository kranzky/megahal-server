class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :utterance, index: true
      t.timestamps null: false
    end
    add_foreign_key :jobs, :utterances
  end
end
