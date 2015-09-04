class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :albums, dependent: :destroy

  validates :username, uniqueness: true, presence: true
  validates :password, presence: true

  def self.authenticate(username,password)
    @user = User.find_by_username(username)

    if @user
      if password == @user.password
        return @user
      else
        return false
      end
    end
  end

end
