class CleartextController < ApplicationController
  def index
    @cleartext = Passwords.all
  end

  def search
    @cleartext = Passwords.search_cleartext(params[:q])
    if @cleartext.empty?
      flash[:info] = 'Password not found, adding to generation queue'
      Passwords.new.add_cleartext_one(params[:q])
    end
  end
end
