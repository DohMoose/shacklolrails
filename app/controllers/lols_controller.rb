class LolsController < InheritedResources::Base
  respond_to :json
  actions :create
  before_filter :ensure_scope

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
  def cache_output
    response.headers['Cache-Control'] = 'public, max-age=60'
  end

  def ensure_scope
    if request.query_string.blank? 
      params[:article_id] = 17 
    end
  end
     
end
