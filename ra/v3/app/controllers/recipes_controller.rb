class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params())
    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new!"
    else
      render 'new'
    end
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update(recipe_params())
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to root_path, notice: "Successfully update"
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image,
                                   ingredients_attributes: [:id, :name, :_destroy],
                                   directions_attributes: [:id, :step, :_destroy])
  end

end
