class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :batches
  has_many :cookie, :through => :batch, as: :storage

  validates :user, presence: true
end
