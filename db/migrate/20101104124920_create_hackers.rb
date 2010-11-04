class CreateHackers < ActiveRecord::Migration
  def self.up
    create_table :hackers do |t|
      t.string :username, :null => false
      t.string :gravatar_id
      t.integer :ranking, :default => 1500

      t.timestamps
    end

    add_index :hackers, :ranking
    add_index :hackers, :username, :unique => true
  end

  def self.down
    drop_table :hackers
  end
end
