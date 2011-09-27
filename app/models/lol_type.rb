class LolType < ActiveRecord::Base
  has_many :lols

  def self.get(name)
    find_or_create_by_name(name)
  end
end
