class Analysis < ActiveRecord::Base
  serialize :lold_by, Array
  belongs_to :link
  belongs_to :lol_type

  scope :date, 
    lambda { |day|
      timezone_date = DateTime.parse(day).in_time_zone
      joined.
      where("links.date > ? and links.date <= ?", timezone_date, timezone_date+1.day)
  } 

  scope :authored_by, 
    lambda { |shackname|
      joined.
      where("links.user_id = ?", User.get(shackname))
  } 

  scope :lold_by,
    lambda { |shackname|
      joined.
      joins("inner join lols on lols.link_id = analyses.link_id and lols.lol_type_id = analyses.lol_type_id").
      where("lols.user_id = ?", User.get(shackname))
  }

  scope :tag,
    lambda { |tagname|
      joined.
      where(lol_type_id: LolType.get(tagname))
  }

  scope :list_order,
    lambda { |type|
      order_statement = (type == 'lols') ? "total desc" : "links.date desc"
      joined.
      order(order_statement).order("last_lol_id desc")
  }


  scope :joined,  
      joins(:link).
      includes(:link).
      joins(:lol_type).
      includes(:lol_type)
  


  def self.for_single_lol(lol)
    similar = lol.similar.to_a
    analysis = Analysis.find_or_initialize_by_link_id_and_lol_type_id(
        link_id: lol.link_id,
        lol_type_id: lol.lol_type_id,
        total: 0,
        lold_by: ''
    )

    analysis.total = similar.count
    analysis.lold_by = similar.map{|lol| lol.user.shackname}
    analysis.last_lol_id = lol.id
    analysis.save

  end
end
