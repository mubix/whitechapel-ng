Whitechapel::Application.routes.draw do

  get "upload/index"
  root 'application#index'
  
  get 'hashes' => 'pwhashes#index'
  get 'hashes/search' => 'pwhashes#search'
  get 'hashes/search/:q' => 'pwhashes#search'
  get 'hashes/cleartext/:id' => 'pwhashes#cleartext_lookup', :as => :cleartext_lookup
  
  get 'cleartext' => 'cleartext#index'
  get 'cleartext/search' => 'cleartext#search'
  get 'cleartext/search/:q' => 'cleartext#search'
  get 'cleartext/export' => 'cleartext#export', :as => :cleartext_export

  post 'upload/upload_pwdump' => 'upload#upload_pwdump',:as => :upload_pwdump
  post 'upload/upload_wordlist' => 'upload#upload_wordlist',:as => :upload_wordlist


end
