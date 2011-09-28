class User < ActiveRecord::Base
  has_many :lols
  has_many :links

  
  def self.get(shackname)
    find_or_create_by_shackname(shackname)
  end




end
