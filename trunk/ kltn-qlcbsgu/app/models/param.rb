class Param < ActiveRecord::Base
  attr_accessible :param_name, :param_value, :options, :description
  validates_uniqueness_of :param_name
  def self.search(search_value)
    if search_value
      where('param_name LIKE ?',"%#{search_value}%")
    else
      scoped
    end
  end

  def self.get_param_value(param_name)
    value = Param.find_by_param_name("#{param_name}")
    if value
      return value.param_value.to_s
    else
      return param_name.tr('_', ' ')
    end
  end

  def self.sort_by(attribute_name)
    order attribute_name
  end

end