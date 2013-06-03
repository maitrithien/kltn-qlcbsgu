class AddCongViecIdToCanBoCongTac < ActiveRecord::Migration
  def change
    add_column :can_bo_cong_tacs, :cong_viec_id, :integer, :null=>false
  end
end
