class Admin::ItemsController < ApplicationController

 before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10)

      if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.order(created_at: :desc).where(is_active: "販売中").page(params[:page]).per(8)
      else
      @items = Item.where(is_active: "販売中").page(params[:page]).per(12)
      end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :image_id, :name, :introduction, :price, :is_active)
  end
end




