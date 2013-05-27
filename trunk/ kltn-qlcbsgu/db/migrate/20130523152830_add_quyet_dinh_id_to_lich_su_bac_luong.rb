class AddQuyetDinhIdToLichSuBacLuong < ActiveRecord::Migration
  def change
    add_column :lich_su_bac_luongs, :quyet_dinh_id, :integer
  end
end
