class CreateParams < ActiveRecord::Migration
  def self.up
    create_table :params do |t|
      t.string :param_name
      t.string :param_value
      t.string :options
      t.string :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :params
  end
end