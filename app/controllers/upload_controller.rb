class UploadController < ApplicationController
  def index
  end

  def upload_wordlist
  	if params[:wordlist]
  		if params[:source]
  			source = params[:source]
  		else
  			source = "Uploaded"
  		end
	    require 'fileutils'
	    tmp = params[:wordlist].tempfile
	    file_path = File.join("tmp/", "#{SecureRandom.hex(32)}.txt")
	    FileUtils.cp tmp.path, file_path
	    Passwords.delay.add_cleartext_list(file_path, source)
	    redirect_to root_path
	  else
	    flash[:error] = "Error: Please select a file"
	    redirect_to upload_index_path
	  end
  end

  def upload_pwdump
	  if params[:pwdump_format]
	    require 'fileutils'
	    tmp = params[:pwdump_format].tempfile
	    file = File.join("tmp/", "#{SecureRandom.hex(32)}.txt")
	    FileUtils.cp tmp.path, file
	    redirect_to root_path
	  else
	    flash[:error] = "Error: Please select a file"
	    redirect_to upload_index_path
	  end
  end

end
