class CookieBakerWorker
  include Sidekiq::Worker

	BAKING_DURATION_SECONDS = 5

	def perform(batch_id)
    sleep BAKING_DURATION_SECONDS
    
    batch = Batch.find(batch_id)
    batch.status = :baked
    batch.save

    batch.cookies.each do |cookie|
      cookie = Cookie.find_by(id: cookie.id)  
      return unless cookie
      cookie.update!(status: :baked)
    end
	end
end