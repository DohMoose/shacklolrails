module AnalysesHelper
  def user_action
    case 
    when params["authoredby"]
      "'s #{show_current_tag} Posts"
    when params["loldby"]
      "'s #{show_current_tag}'s"
    when params["fantrain"]
      "'s #{show_current_tag} Fan Train"
    when params["fanof"]
      " Is a #{show_current_tag} Fan Of..."
    when params["user"]
      "'s #{show_current_tag} Stats"
    end
  end
end
