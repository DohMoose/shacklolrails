namespace :db do
  include ActionView::Helpers::NumberHelper
  def random_user
    offset = rand(User.count)
    User.first(:offset => offset)
    
  end
  desc "grab a bunch of posts"
  task :populate,[ :posts, :last_id]  => :environment do |t, args|
     args.with_defaults(:posts => 1000, :last_id => 267963661)



    User.find_or_create_by_shackname('filthysock')
    lol_types = ['lol', 'wtf', 'unf']
    start_id = args[:last_id].to_i
    size = args[:posts].to_i
    size.times do |count|
      post_id = start_id - count
      lol = Lol.new(
        tag: lol_types.sample,
        who: random_user.shackname,
        what: post_id
      )

      puts "#{post_id}:#{number_to_percentage(  (count / size.to_f) * 100 )}"
      
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
