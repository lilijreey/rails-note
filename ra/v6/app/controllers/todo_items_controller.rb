class TodoItemsController < ApplicationController

  def create
    @list = find_list()
    @item = @list.todo_items.create(todo_item_params())

    redirect_to @list
  end

  def complete
    @todo_list = find_list()
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)

    redirect_to @todo_list, notice: "Toto item completed"
  end

  def show
    @todo_item = TodoItem.find(params[:id])
  end

  def destroy
    @todo_list = find_list()
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.destroy
      flash[:success] = "Delete successfully"
    else
      flash[:error] = "Could not be delete"
    end

    redirect_to @todo_list
  end


  private

  def find_list
    TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
