class Lol < ActiveRecord::Base
  before_validation :transpose
  after_save :update_analysis

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

 scope :tag,
    lambda { |tagname|
      where(lol_type_id: LolType.get(tagname))
  }

  scope :group_by_shackname,
    joins(:user).group("shackname")

  scope :most_lold,
    joins(:link => :user).group("shackname").order("count(*) desc")

  def similar
    Lol.where(link_id: self.link_id, lol_type_id: self.lol_type_id).joins(:user).includes(:user)
  end


    

private
  def update_analysis
    Analysis.for_single_lol(self)
  end

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
