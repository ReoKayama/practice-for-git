Rails.application.routes.draw do
    root 'static_pages#home'
    
    resources :users
    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create'
    
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    
    resources :lectures
    get '/lecture_list', to: 'lectures#lecture_list'
    post '/lecture_search', to: 'lectures#lecture_search'
    get "lecture_review/:lecture_id/:user_id", to: 'lectures#lecture_review'
    post 'lecture_review/:lecture_id/:user_id', to: 'lectures#lecture_answer'
    get 'lecture_favorite/:lecture_id/:user_id', to: 'lectures#lecture_favorite'
    get '/fav_delete/:lecture_id/:user_id', to: 'lectures#lecture_delete'
end
