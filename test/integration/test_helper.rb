
class ActionDispatch::IntegrationTest
  def login_as(user)
    if defined? post
      post login_url, params: { name: user.name, password: 'secret' }
    end
  end

  def logout
    delete logout_url
  end

  def setup
    login_as users(:one)
  end
end
