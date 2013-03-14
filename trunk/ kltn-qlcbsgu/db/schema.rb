# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130314093753) do

  create_table "bac_luongs", :force => true do |t|
    t.integer  "ngach_id"
    t.integer  "bac"
    t.float    "he_so_luong"
    t.string   "ghi_chu"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "vuot_khung",  :default => false
  end

  create_table "can_bo_cong_tacs", :force => true do |t|
    t.integer  "can_bo_thong_tin_id"
    t.integer  "don_vi_id"
    t.string   "nghe_nghiep_truoc_tuyen_dung"
    t.string   "cong_viec_chinh_duoc_giao"
    t.string   "so_truong_cong_tac"
    t.date     "ngay_bat_dau_lam_viec"
    t.string   "ghi_chu"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "can_bo_li_lich_cts", :force => true do |t|
    t.integer  "can_bo_thong_tin_id"
    t.date     "ngay_vao_dang"
    t.date     "ngay_nhap_ngu"
    t.date     "ngay_xuat_ngu"
    t.string   "quan_ham_cao_nhat"
    t.string   "danh_hieu_duoc_phong_tang"
    t.string   "thuong_binh_hang"
    t.string   "con_gia_dinh_chinh_sach"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "can_bo_thong_tins", :force => true do |t|
    t.string   "ma_cb"
    t.string   "ho_ten"
    t.string   "ten_goi_khac",                   :limit => 225
    t.boolean  "gioi_tinh",                                     :default => true,  :null => false
    t.string   "hinh_anh"
    t.date     "ngay_sinh"
    t.string   "noi_sinh"
    t.string   "que_quan"
    t.string   "dan_toc"
    t.string   "ton_giao"
    t.string   "so_cmnd"
    t.date     "ngay_cap_cmnd"
    t.string   "so_BHXH"
    t.string   "noi_dang_ky_ho_khau_thuong_tru"
    t.string   "noi_o_hien_nay"
    t.string   "tep_tin_dinh_kem"
    t.boolean  "is_deleted",                                    :default => false, :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "can_bo_thong_tins", ["ma_cb"], :name => "ma_cb", :unique => true

  create_table "can_bo_trinh_dos", :force => true do |t|
    t.string   "trinh_do_gd_pho_thong"
    t.integer  "can_bo_thong_tin_id"
    t.integer  "trinh_do_chuyen_mon_id"
    t.integer  "chuyen_nganh_id"
    t.integer  "ly_luan_chinh_tri_id"
    t.integer  "quan_ly_nha_nuoc_id"
    t.integer  "ngoai_ngu_id"
    t.integer  "hoc_ham_id"
    t.integer  "hoc_vi_id"
    t.string   "trinh_do_ngoai_ngu"
    t.string   "trinh_do_tin_hoc"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "casein_users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        :default => 0, :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "chuc_vus", :force => true do |t|
    t.string   "ten_chuc_vu"
    t.float    "he_so_phu_cap"
    t.string   "ghi_chu"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "chuyen_nganhs", :force => true do |t|
    t.string   "ten_chuyen_nganh"
    t.string   "ghi_chu"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "don_vis", :force => true do |t|
    t.string   "ten_don_vi"
    t.string   "dia_chi"
    t.string   "so_dien_thoai"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "hoc_hams", :force => true do |t|
    t.string   "ten_hoc_ham"
    t.string   "ghi_chu"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hoc_vis", :force => true do |t|
    t.string   "ten_hoc_vi"
    t.string   "ghi_chu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lich_su_bac_luongs", :force => true do |t|
    t.integer  "bac_luong_id"
    t.integer  "can_bo_thong_tin_id"
    t.date     "ngay_thay_doi_bac"
    t.string   "ghi_chu"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "loai_quyet_dinhs", :force => true do |t|
    t.string   "ten_loai_qd"
    t.string   "ghi_chu"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ly_luan_chinh_tris", :force => true do |t|
    t.string   "trinh_do"
    t.string   "ghi_chu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ngaches", :force => true do |t|
    t.string   "ma_ngach"
    t.string   "ten_ngach"
    t.integer  "nien_han"
    t.string   "ghi_chu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ngoai_ngus", :force => true do |t|
    t.string   "ten_ngoai_ngu"
    t.string   "ghi_chu"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "params", :force => true do |t|
    t.string   "param_name"
    t.string   "param_value"
    t.string   "options"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "qua_trinh_cong_tacs", :force => true do |t|
    t.integer  "can_bo_thong_tin_id"
    t.integer  "don_vi_id"
    t.integer  "chuc_vu_id"
    t.date     "thoi_gian_bat_dau"
    t.date     "thoi_gian_ket_thuc"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "quan_ly_nha_nuocs", :force => true do |t|
    t.string   "trinh_do"
    t.string   "ghi_chu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "quyet_dinhs", :force => true do |t|
    t.integer  "loai_quyet_dinh_id"
    t.string   "so_qd"
    t.date     "ngay_ra_qd"
    t.string   "noi_dung_tom_tat"
    t.string   "tep_tin_dinh_kem"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "than_nhans", :force => true do |t|
    t.integer  "can_bo_thong_tin_id"
    t.string   "quan_he_voi_cb"
    t.integer  "nam_sinh"
    t.string   "nghe_nghiep"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "ho_ten",              :null => false
  end

  create_table "trinh_do_chuyen_mons", :force => true do |t|
    t.string   "trinh_do"
    t.string   "ghi_chu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
