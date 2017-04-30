Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/rate/', to: 'rate#index'

  get '/rate/show', to: 'rate#show'

  get '/rate/update', to: 'rate#update'

  get '/rate/del', to: 'rate#delete'

  ###
  get '/jcr/', to: 'jcr#index'
 
  get '/jcr/show', to: 'jcr#show'


end
