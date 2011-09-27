class LinksController < InheritedResources::Base
  respond_to :html, :json
  actions :index

  has_scope :date, default: DateTime.now.in_time_zone.to_s

end
