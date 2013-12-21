class PwhashesController < ApplicationController
  def index
    @pwhashes = Pwhashes.all.includes(:type, :password, :status)
  end

  def cleartext_lookup
    @pwhashes = Pwhashes.where(password_id: params[:id]).includes(:type, :password)
    if @pwhashes.empty?
      flash[:info] = 'Hash not found'
      @cleartext = []
    else
      @cleartext = @pwhashes.first.password.cleartext
    end
  end

  def search
    @pwhashes = Pwhashes.search_hashes(params[:q])
    if @pwhashes.empty?
      flash[:warning] = 'Hash not found'
    end
  end
end
