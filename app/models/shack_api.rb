require 'net/http'
require 'uri'

class ShackApi
  @@host = 'shackapi.stonedonkey.com'

  class << self 
    attr_accessor :cache_urls
    attr_accessor :url_cache
    def get_comment(id)
      url = "#{@@host}/thread/#{id}.json"
      content = get(url)
      
      original_post = content['comments'][0]
      comment = search_replies(id.to_s, original_post)
      return original_post, comment 
    end

    def search_replies(id, content)
      return content if (id == content['id'])
      content["comments"].each do |comment|
        found = search_replies(id, comment)
        return found if found
      end
      nil
    end

    def get(url)

      if cache_urls
        url_cache ||= {}
        if (url_cache[url])
          return url_cache[url]
        end
      end
      url = "http://#{url}"

      res = Net::HTTP.get(URI.parse(url))

      parsed_result = JSON.parse(res, max_nesting: false)
      if cache_urls
        url_cache[url] = parsed_result
      end
      parsed_result
    end
  end
end
