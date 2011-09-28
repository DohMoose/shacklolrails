module LolsHelper
  def current_date_scope 
    current_scopes[:date]
  end

  def current_date
    @current_date ||= DateTime.parse(current_date_scope)
  end

  def authored_by
    @current_authored_by ||= current_scopes[:authored_by]
  end
end
