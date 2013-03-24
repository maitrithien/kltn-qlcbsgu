class AddCapBacQuanDoiToCanBoLiLichcc < ActiveRecord::Migration
  def change
    add_column :can_bo_li_lich_cts, :cap_bac_quan_doi_id, :integer
  end
end
