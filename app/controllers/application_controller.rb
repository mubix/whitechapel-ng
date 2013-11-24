class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @hashes_count_total = Pwhashes.all.count
    @cleartext_count_total = Passwords.all.count
  end
end
