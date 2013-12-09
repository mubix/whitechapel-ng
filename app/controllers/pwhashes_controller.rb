class PwhashesController < ApplicationController
  def index
    @pwhashes = Pwhashes.all.includes(:type, :password)
  end

  def cleartext_lookup
    @pwhashes = Pwhashes.where(password_id: params[:id]).includes(:type, :password)
    if @pwhashes.empty?
      @cleartext = []
    else
      @cleartext = @pwhashes.first.password.cleartext
    end
  end

  def search
    @pwhashes = Pwhashes.search_hashes(params[:q])
    if @pwhashes.empty?
      flash[:warning] = 'Password not found, Please add to the cracking queue'
    end
  end
end
