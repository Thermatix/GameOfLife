require "Gol_Controller"

class MainController < ApplicationController
  def index

   @golcontroller = Golcontroller.new
   render views: "gol"
  end
end
