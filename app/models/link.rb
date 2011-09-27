class Link < ActiveRecord::Base
  has_many :lols
  belongs_to :user

  scope :date, 
    lambda { |day|
      timezone_date = DateTime.parse(day).in_time_zone
      where("links.date > ? and links.date <= ?", timezone_date, timezone_date+1.day)
  }
 

  def self.get(post_id)
    link = where(post_id: post_id).first
    unless link
      original_post, comment = ShackApi.get_comment(post_id)
      link = Link.create!(
          post_id: comment["id"], 
          original_post_id: original_post["id"],
          cache: comment["body"], 
          date: comment["date"],
          user: User.get(comment["author"]))
    end
    link
  end
end
