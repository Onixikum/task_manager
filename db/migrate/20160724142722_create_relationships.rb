class CreateRelationships < ActiveRecord::Migration #:nodoc:
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :task_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :task_id
    add_index :relationships, [:follower_id, :task_id], unique: true
  end
end
