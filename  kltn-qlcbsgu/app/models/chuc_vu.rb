class ChucVu < ActiveRecord::Base
    attr_accessible :ghi_chu ,:ten_chuc_vu, :he_so_phu_cap

    validates_presence_of :ten_chuc_vu, :message => "#{Param.get_param_value("is_not_blank")}"
    validates_uniqueness_of :ten_chuc_vu, :message => "#{Param.get_param_value "has_been_already_taken"}"

    has_many :qua_trinh_cong_tacs
end