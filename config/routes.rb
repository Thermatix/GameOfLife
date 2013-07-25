GameOfLife::Application.routes.draw do
 
  
  root to: "gol#index"
  resources :cells
  resources :gol
end
