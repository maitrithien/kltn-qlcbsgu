class ChucVu < ActiveRecord::Base
    attr_accessible :ghi_chu ,:ten_chuc_vu, :he_so_phu_cap
    has_many :qua_trinh_cong_tacs
end