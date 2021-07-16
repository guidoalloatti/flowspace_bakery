class Batch < ActiveRecord::Base
  belongs_to :oven
  has_many :cookies, as: :storage

  def ready?
    status == 'baked'
  end

  def baking?
  	status == 'baking'
  end
end
