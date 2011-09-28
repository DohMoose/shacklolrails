class LolsController < InheritedResources::Base
  respond_to :html, :json
  actions :create

  has_scope :date, default: DateTime.now.in_time_zone.to_s

end
