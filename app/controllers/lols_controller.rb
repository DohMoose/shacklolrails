class LolsController < InheritedResources::Base
  include HerokuCache
  respond_to :json
  actions :create
  before_filter :ensure_scope

  heroku_caches_actions only: :count
  
  has_scope :article_id
  has_scope :chatty_id

  # latestchatty is article 17
  def count
    lols = Analysis.format_lol_counts(apply_scopes(Analysis).sum(:total))
    respond_to do |format|
      format.json { render :json => lols}
    end
  end

  def create
    params[:lol][:ip] = request.ip
    create! { |success, failure|
      success.any { render(text: 'ok') }
      failure.any { render(text: @lol.errors.messages.values.join(","))}
    }
  end

private
  def ensure_scope
    if request.query_string.blank? 
      params[:article_id] = 17 
    end
  end
end
