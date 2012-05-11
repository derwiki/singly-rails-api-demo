Singlyhackathon::Application.routes.draw do
  match 'auth/:service' => 'auth#service'
  match 'auth_callback' => 'auth#callback'
  match 'logout'        => 'auth#logout'
  match 'funnel'        => 'funnel#index'
  match 'network'       => 'default#network'
  root :to              => 'default#home'
end
