GameOfLife::Application.routes.draw do
  get "gol/index"
  root to: "gol#index"
  #resources :grid
end
