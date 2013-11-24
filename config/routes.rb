Whitechapel::Application.routes.draw do

  root 'application#index'
  get 'hashes' => 'pwhashes#index'
  get 'hashes/cleartext/:id' => 'pwhashes#cleartext_lookup', :as => :cleartext_lookup
  get 'cleartext' => 'cleartext#index'

end
