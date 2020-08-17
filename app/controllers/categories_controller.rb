class CategoriesController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
    
  end

  def create

  end

  def show
    
  end
end

