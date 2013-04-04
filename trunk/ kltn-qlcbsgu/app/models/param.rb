class Param < ActiveRecord::Base
  attr_accessible :param_name, :param_value, :options, :description

  validates_presence_of :param_name, :param_value
  validates_uniqueness_of :param_name
  def self.search(search_value)
    if search_value
      where('param_name LIKE ?',"%#{search_value}%")
    else
      scoped
    end
  end

  #build select_year
  def self.select_year(options = {})
    hash = []
    if options.key? :from_year
      if options.key? :end_year
        if options[:from_year] >= options[:end_year]
          return hash
        else
          #set hash with from_year and end_year
          options[:from_year].upto options[:end_year] do |i|
            hash = hash.push(i)
          end
          return hash
        end
      else
        #set hash with default end_year is current year
        options[:from_year].upto Time.now.year.to_i do |i|
          hash = hash.push(i)
        end
        return hash
      end
    else
      #set default hash
      1900.to_i.upto Time.now.year.to_i do |i|
        hash = hash.push(i)
      end
    end

    return hash
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

  def self.thuong_binh_hang
    key = Param.find_by_param_name("thuong_binh_hang_values")
    value = Param.find_by_param_name("thuong_binh_hang_desc")
    hash = {}
    hash_key = []
    hash_value = []

    if key
      hash_key = key.param_value.to_s.split(',').to_a
      if value
        hash_value = value.param_value.to_s.split(',').to_a
        hash_key.each_index do |i|
          hash = hash.merge("#{hash_key[i]} - #{hash_value[i]}" => "#{hash_key[i]}")
        end
        return hash
      else
        hash
      end
    else
      hash
    end

  end

  def self.cap_bac_quan_doi
    value = Param.find_by_param_name("cap_bac_quan_doi")
    hash = {}
    hash_value=[]
      if value
        hash_value = value.param_value.to_s.split(',').to_a
        hash_value.each_index do |i|
             hash = hash.merge("#{hash_value[i]}" => "#{hash_value[i]}")
        end
        return hash
      else
        hash
      end
  end


end