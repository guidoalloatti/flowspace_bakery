class CookieBakerWorker
  include Sidekiq::Worker

	BAKING_DURATION_SECONDS = 1

	def perform(cookie_id) 
    sleep BAKING_DURATION_SECONDS
    
    cookie = Cookie.find_by(id: cookie_id)
    return unless cookie

    cookie.update!(status: :baked)
	end
end