class AddQuyetDinhIdToQuaTrinhCongTac < ActiveRecord::Migration
  def change
    add_column :qua_trinh_cong_tacs, :quyet_dinh_id, :integer
  end
end
