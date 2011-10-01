class User < ActiveRecord::Base
  has_many :lols
  has_many :links
  
  validates :shackname, uniqueness: { case_sensitive: false }

  
  def self.get(shackname)
    User.where("shackname ilike ?", shackname).first || User.create!(shackname:shackname)
  end




end
