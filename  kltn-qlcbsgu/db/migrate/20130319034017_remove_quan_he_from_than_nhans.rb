class RemoveQuanHeFromThanNhans < ActiveRecord::Migration
  def up
    remove_column :than_nhans, :quan_he_voi_cb
  end

  def down
    add_column :than_nhans, :quan_he_gia_dinh_id, :integer
  end
end
