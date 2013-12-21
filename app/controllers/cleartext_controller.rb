class CleartextController < ApplicationController
  def index
    @cleartext = Passwords.all
  end

  def search
    @cleartext = Passwords.search_cleartext(params[:q])
    if @cleartext.empty?
      flash[:info] = 'Password not found, adding to generation queue'
      Passwords.delay.add_cleartext_one(params[:q], "search")
      redirect_to '/'
    else
      @cleartext_title = @cleartext.first.cleartext
      @cleartext_source = @cleartext.first.source
      @pwhashes = Pwhashes.where(password_id: @cleartext.first.id).includes(:type, :password)
    end
  end

  def export
    passwords = Passwords.all
    @content = ""
    passwords.each do |password|
      @content = @content + password.cleartext + "\n"
    end
    send_data @content, :type => 'text', :disposition => "attachment; filename=whitechapel_wordlist.txt"
  end

end
