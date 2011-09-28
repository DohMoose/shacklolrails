class Link < ActiveRecord::Base
  has_many :lols
  has_one :analysis
  belongs_to :user

  scope :date, 
    lambda { |day|
      timezone_date = DateTime.parse(day).in_time_zone
      where("links.date > ? and links.date <= ?", timezone_date, timezone_date+1.day)
  }

 scope :tag,
    lambda { |tagname|
      joins(:analysis).
      where("lol_type_id = ?", LolType.get(tagname))
  }

  scope :most_lold_posts,
    joins(:user).group("shackname").order("count(*) desc")

  def self.get(post_id)
    link = where(post_id: post_id).first
    unless link
      begin
        original_post, comment = ShackApi.get_comment(post_id)
      rescue
        link = Link.create!(
            post_id: post_id, 
            original_post_id: 0,
            cache: "$!.message", 
            date: Datetime.now,
            user: User.get("exception"))
        return link
      end

      begin
        link = Link.create!(
            post_id: comment["id"], 
            original_post_id: original_post["id"],
            cache: comment["body"], 
            date: comment["date"],
            user: User.get(comment["author"]))
      rescue 
        link = Link.create!(
            post_id: post_id, 
            original_post_id: original_post["id"],
            cache: 'nuke', 
            date: original_post["date"],
            user: User.get("nuked"))
      end
    end
    link
  end
end
