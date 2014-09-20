Rails.application.routes.draw do

  post 'users' => 'users#login'

  resources :trips, except: [:new, :edit]

  get 'trips/:id/candidates' => 'candidates#find', as: 'candidates'
  post 'trips/:a_id/candidates/:b_id/acceptation' => 'candidates#accept', as: 'candidate_accept'
  post 'trips/:a_id/candidates/:b_id/rejection'   => 'candidates#reject', as: 'candidate_reject'

  get 'trips/:id/matches' => 'matches#index', as: 'matches'

  get 'trips/:id/matches/:other_id/messages' => 'messages#index', as: 'match_message'
  post 'trips/:id/matches/:other_id/messages' => 'messages#create'

end
