Gemcutter::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true

  config.consider_all_requests_local = true
  config.action_view.debug_rjs                         = true
  config.action_controller.perform_caching             = false
  config.active_support.deprecation = :log
  config.action_mailer.raise_delivery_errors = false
end


# Currently, we use the same search as in production.
#
FullGems = Picky::Client::Full.new :host => 'gemsearch-server.heroku.com', :port => 80, :path => '/gems/full'
LiveGems = Picky::Client::Live.new :host => 'gemsearch-server.heroku.com', :port => 80, :path => '/gems/live'