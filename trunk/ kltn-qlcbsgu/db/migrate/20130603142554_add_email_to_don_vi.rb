class AddEmailToDonVi < ActiveRecord::Migration
  def change
    add_column :don_vis, :email, :string
  end
end
