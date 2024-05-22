class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new # Needed to instantiate the form_with
  end

  def create
    # raise
    @list = List.new(list_params)
    @list.save
    if @list.save
      redirect_to lists_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
