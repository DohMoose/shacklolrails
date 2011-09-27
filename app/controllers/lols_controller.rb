class LolsController < InheritedResources::Base
  respond_to :html, :json
  actions :index, :create

  has_scope :date, default: DateTime.now.in_time_zone.to_s


  def collection
    @lols = end_of_association_chain.group_by{|lol| [lol.link, lol.lol_type.name]}.sort{|a,b| (-1)*(a[1].length <=> b[1].length)}
  end
end
