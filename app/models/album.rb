class Album < ActiveRecord::Base
  # Remember to create a migration!
  has_many :photos, dependent: :destroy
  belongs_to :user
end
