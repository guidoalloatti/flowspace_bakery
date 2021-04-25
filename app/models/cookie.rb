class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  validates_presence_of :fillings, message: "no fillings!"

  def ready?
    true
  end
end
