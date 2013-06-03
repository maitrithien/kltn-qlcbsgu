class AddLoaiDonViIdToDonVi < ActiveRecord::Migration
  def change
    add_column :don_vis, :loai_don_vi_id, :integer
  end
end
