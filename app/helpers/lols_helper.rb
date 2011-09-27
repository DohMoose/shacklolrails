module LolsHelper
  def current_date
    @current_date = DateTime.parse(current_scopes[:date])
  end
end
