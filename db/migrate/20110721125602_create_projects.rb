class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    
    add_index :projects, :user_id
  end

  def self.down
    drop_table :projects
  end
end
