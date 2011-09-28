module ApplicationHelper
  def format_date(date)
    date.to_date.to_s :db
  end

  def format_datetime(date)
    date.to_datetime.in_time_zone.to_s :db
  end

  def post_link(id)
    "http://www.shacknews.com/chatty?id=#{id}"
  end

  def permalink(id, html=id)
    %{<a href="#{post_link(id)}" class="permalink" title="Permalink">#{html}</a>}.html_safe
  end

  def self_lol(post_id, tag)
    %{[<a data-remote="true" href= "/lols/lol?who=#{current_shacker}&amp;what=#{post_id}&amp;tag=#{tag}&amp;version=-1" id="#{tag}#{post_id}" class="c1" name="#{tag}#{post_id}">#{tag}</a>]}.html_safe
  end

  def current_shacker
    "filthysock"
  end
end
