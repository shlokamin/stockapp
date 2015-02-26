Rails.application.routes.draw do
  get '/', to: 'application#index'
  get '/data/:stock', to: 'application#data'


end
