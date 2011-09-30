class AnalysesController < InheritedResources::Base
  respond_to :html
  actions :index, :user
  before_filter :ensure_scope
  before_filter :cache_output

  has_scope :date, only: :index
  has_scope :authored_by, as: 'authoredby', only: [:index, :user]
  has_scope :lold_by, as: 'loldby', only: [:index, :user]
  has_scope :tag
  has_scope :list_order, as: 'sort_by', default: 'lols', only: [:index, :user]

  has_scope :fan_train, as: 'fantrain', only: :follow
  has_scope :fan_of, as: 'fanof', only: :follow 

  def masters
    @most = apply_scopes(Lol).most_lold.limit(25).count
    @most_posts = apply_scopes(Link).most_lold_posts.limit(25).count
  end

  def who
    @whos = apply_scopes(Lol).joins(:user).group_by_shackname.order("shackname").count
  end

  def user
  end
  
  def follow
    @whos = apply_scopes(Lol).group_by_shackname.order("count(*) desc").count
  end

  def stats
    current_shacker = params["user"]
    @total_lold = apply_scopes(Lol).fan_of(current_shacker)
    @total_posts = apply_scopes(Analysis).authored_by(current_shacker)
    @total_lols = apply_scopes(Lol).fan_train(current_shacker)
  end

private
  def cache_output
    response.headers['Cache-Control'] = 'public, max-age=60'
  end

  def collection
    @analyses ||= end_of_association_chain.page(params[:page])
  end

  def ensure_scope
    if request.query_string.blank? 
      params[:date] = DateTime.now.in_time_zone.to_date.to_s
    end
  end

end
