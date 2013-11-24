class CleartextController < ApplicationController
  def index
    @cleartext = Passwords.all
  end
end
