class LolsController < InheritedResources::Base
  respond_to :json
  actions :create
  before_filter :ensure_scope

  has_scope :article_id
  has_scope :chatty_id

  # latestchatty is article 17
  def count
    lols = Analysis.format_lol_counts(apply_scopes(Analysis).count)
    respond_to do |format|
      format.json { render :json => lols}
    end
    
  end

private
  def ensure_scope
    if request.query_string.blank? 
      params[:article_id] = 17 
    end
  end
     
end
