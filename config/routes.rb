GameOfLife::Application.routes.draw do
  get "main/index"
  get "gol/index"
  root to: "gol#index"
  resources :cells
  resources :gol
end
