Whitechapel::Application.routes.draw do

  root 'application#index'
  get 'hashes' => 'pwhashes#index'
  get 'hashes/cleartext/:id' => 'pwhashes#cleartext_lookup', :as => :cleartext_lookup
  post 'hashes/search' => 'pwhashes#search'
  get 'cleartext' => 'cleartext#index'
  post 'cleartext/search' => 'cleartext#search'

end
