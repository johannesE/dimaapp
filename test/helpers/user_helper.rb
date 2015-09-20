class UserHelper
  include Devise::TestHelpers

  def login_user
    Warden.test_mode!
    user = users(user_one)
    login_as user, :scope => :user
    user.confirmed_at = Time.now
    user.confirm!
    user.save
    user
  end

end