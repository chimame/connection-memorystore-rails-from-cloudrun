Rails.application.routes.draw do
  resource :top, only: [:show]
end
