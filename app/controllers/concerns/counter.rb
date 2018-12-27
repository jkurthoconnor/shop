module Counter

  private
  def increment_counter
    session[:counter] || set_session_counter
    session[:counter] += 1
    set_ivar_counter
  end

  def reset_counter
    set_session_counter
  end

  def set_session_counter
    session[:counter] = 0
  end

  def set_ivar_counter
    @counter = session[:counter]
  end
end
