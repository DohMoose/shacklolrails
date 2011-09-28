class AnalysesController < InheritedResources::Base
  respond_to :html
  actions :index, :masters, :who
  before_filter :ensure_scope

  has_scope :date, only: :index
  has_scope :authored_by, as: 'authoredby', only: :index
  has_scope :lold_by, as: 'loldby', only: :index
  has_scope :tag
  has_scope :list_order, as: 'sort_by', default: 'lols', only: :index

  def masters
    @most = apply_scopes(Lol).most_lold.limit(25).count
    @most_posts = apply_scopes(Link).most_lold_posts.limit(25).count
  end

  def who
    @whos = apply_scopes(Lol).group_by_shackname.order("shackname").count
  end

private

  def collection
    @analyses ||= end_of_association_chain.page(params[:page])
  end

  def ensure_scope
    if request.query_string.blank? 
      params[:date] = DateTime.now.in_time_zone.to_s
    end
  end

end
