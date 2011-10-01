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

  scope :chatty_id,
    lambda { |chatty_id|
      original_post_id = Link.get(chatty_id).original_post_id
      joined.
      where("links.original_post_id = ?", original_post_id).
      sum_group
  }

  scope :article_id,
    lambda { |article_id| 
      if (article_id.to_i == Link::LATEST_CHATTY_ARTICLE_ID)
        where_clause = ["links.date > ?", (DateTime.now.in_time_zone - 18.hours)]
      else
        where_clause = {"links.article_id" => article_id}
      end

      joined.
      where(where_clause).
      sum_group
    }

  scope :sum_group,
      group("original_post_id","post_id",  "lol_type_id").
      order("original_post_id", "post_id", "lol_type_id")

  scope :joined,  
      joins(:link).
      includes(:link).
      joins(:lol_type).
      includes(:lol_type)
  


  def self.format_lol_counts(lol_counts)
    lol_counts.inject({}) do |h,v| 
      original_post_id = v[0][0]
      post_id = v[0][1]
      lol_type = LolType.find(v[0][2]).name

      h[original_post_id] ||= {} 
      h[original_post_id][post_id] ||= {}
      h[original_post_id][post_id][lol_type] = v[1];

      h
    end
  end

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
