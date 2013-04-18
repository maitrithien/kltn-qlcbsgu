class AddDonViToCanBoThongTin < ActiveRecord::Migration
  def change
    add_column :can_bo_thong_tins, :don_vi_id, :integer
  end
end
