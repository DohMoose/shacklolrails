class AnalysesController < InheritedResources::Base
  respond_to :html
  actions :index
  before_filter :ensure_scope

  has_scope :date
  has_scope :authored_by, as: 'authoredby'
  has_scope :lold_by, as: 'loldby'
  has_scope :tag
  has_scope :list_order, as: 'sort_by', default: 'lols'


private
  def ensure_scope
    if request.query_string.blank? 
      params[:date] = DateTime.now.in_time_zone.to_s
    end
  end

end
