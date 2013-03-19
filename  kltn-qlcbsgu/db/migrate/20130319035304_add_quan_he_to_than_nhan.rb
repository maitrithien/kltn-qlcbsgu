class AddQuanHeToThanNhan < ActiveRecord::Migration
  def change
    add_column :than_nhans, :quan_he_gia_dinh_id, :Integer
  end
end
