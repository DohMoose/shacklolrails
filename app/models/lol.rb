class Lol < ActiveRecord::Base
  before_validation :transpose

  belongs_to :lol_type
  belongs_to :user
  belongs_to :link


  attr_accessor :who #shacker
  attr_accessor :what #post_id
  attr_accessor :tag #lol_type

  scope :date, 
    lambda { |day|
      timezone_date = DateTime.parse(day).in_time_zone
      joins(:user).
      joins(:link).
      includes(:user).
      includes(:link).
      where("links.date > ? and links.date <= ?", timezone_date, timezone_date+1.day)
  } 

    

private
  def transpose
    # we already have proper ids
    return if lol_type

    # we don't have the info to transpose
    return if who.blank?

    self.link = Link.get(what)
    self.user = User.get(who)
    self.lol_type =  LolType.get(tag) 

  end
end
