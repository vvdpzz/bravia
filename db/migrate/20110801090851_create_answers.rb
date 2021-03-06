class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.string :username
      t.references :question
      t.text :content
      t.text :markdown

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
