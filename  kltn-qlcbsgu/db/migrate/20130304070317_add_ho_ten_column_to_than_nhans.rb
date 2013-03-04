class AddHoTenColumnToThanNhans < ActiveRecord::Migration
  def change
    add_column :than_nhans, :ho_ten, :string, :null => false
  end
end
