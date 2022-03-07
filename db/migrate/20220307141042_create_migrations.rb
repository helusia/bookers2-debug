class CreateMigrations < ActiveRecord::Migration[6.1]
  def change
    create_table :migrations do |t|
      t.string :AddFollower_idToRelationship
      t.integer :follower_id

      t.timestamps
    end
  end
end
