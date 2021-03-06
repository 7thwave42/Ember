class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = policy_scope(Item)
    if params[:search_tag].present?
      @items = Item.tagged_with(params[:search_tag])
    end
  end

  def show
    authorize @item
  end

  def update
    @item.update(tag_list: params[@item.class.name.downcase][:tag_list])
    authorize @item
    redirect_to journey_path(@item.journey)
  end

  def destroy
    @item = @item.destroy
    authorize @item
    redirect_to journey_path(@item.journey), notice: "Successfully deleted!"
  end

  private

  def item_params
    params.require(:item).permit(:name, :comment, :content, :tag_list)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
