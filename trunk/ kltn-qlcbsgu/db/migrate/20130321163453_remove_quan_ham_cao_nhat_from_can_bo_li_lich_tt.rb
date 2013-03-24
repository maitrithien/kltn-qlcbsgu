class RemoveQuanHamCaoNhatFromCanBoLiLichTt < ActiveRecord::Migration
  def up
    remove_column :can_bo_li_lich_cts, :quan_ham_cao_nhat
  end

end
