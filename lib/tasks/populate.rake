namespace :db do
  include ActionView::Helpers::NumberHelper
  def random_user
    offset = rand(User.count)
    User.first(:offset => offset)
    
  end
  desc "grab a bunch of posts"
  task :populate => :environment do
    User.find_or_create_by_shackname('filthysock')
    lol_types = ['lol', 'wtf', 'unf']
    start_id = 26353521
    size = 50000
    start_id.upto(start_id + size) do |post_id|
      lol = Lol.new(
        tag: lol_types.sample,
        who: random_user.shackname,
        what: post_id
      )

      puts "#{post_id}:#{number_to_percentage( ((post_id-start_id) / size.to_f) * 100 )}"
      
      begin
        lol.save
      rescue
        puts "sigh #{$!.message}"
      end

    end
  end

  task :update_article_id => :environment do
    links = Link.where(article_id: nil).where("post_id > 0")
    count = links.count
    puts "#{count} links"
    links.all.each_with_index do |link, index|
       puts "#{link.post_id}:#{number_to_percentage( (index / count.to_f) * 100 )}"

       original_post, comment, article_id = ShackApi.get_comment(link.post_id)
       link.article_id = article_id
       link.save!
    end


  end
end
