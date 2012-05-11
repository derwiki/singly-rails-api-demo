Singlyhackathon::Application.routes.draw do
  match 'auth/:service' => 'auth#service'
  match 'auth_callback' => 'auth#callback'
  match 'logout'        => 'auth#logout'
  root :to              => 'default#home'
end
