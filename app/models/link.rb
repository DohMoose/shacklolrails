class Link < ActiveRecord::Base
  has_many :lols
  has_one :analysis
  belongs_to :user

  LATEST_CHATTY_ARTICLE_ID = 17

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

  def self.get(post_id, moderation=nil)
    link = where(post_id: post_id).first

    if link
      link.moderation = moderation
      link.save
    else
      begin
        original_post, comment, article_id = ShackApi.get_comment(post_id)
      rescue
        link = Link.create!(
            post_id: post_id, 
            article_id: 0,
            original_post_id: 0,
            cache: 'nuked',
            date: 10.years.ago,
            user: User.get("duke nuked"))
        return link
      end

      begin
        link = Link.create!(
            post_id: post_id, 
            article_id: article_id,
            original_post_id: original_post["id"],
            cache: comment["body"], 
            date: comment["date"],
            user: User.get(comment["author"]))
      rescue 
        link = Link.create!(
            post_id: post_id, 
            article_id: article_id,
            original_post_id: original_post["id"],
            cache: 'nuked', 
            date: original_post["date"],
            user: User.get("duke nuked"))
      end
    end
    link
  end
end
