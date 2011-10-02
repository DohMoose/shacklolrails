# setting the response headers tells the heroku router to
# cache the output
module HerokuCache
  extend ActiveSupport::Concern

  module ClassMethods
    def heroku_caches_actions(options={})
      before_filter :cache_output, options if Rails.env.production?
    end
  end

  module InstanceMethods
    def cache_output
      response.headers['Cache-Control'] = 'public, max-age=60'
    end
  end
end
