class HomesController < ApplicationController


def top
     @items = Item.where(sale_status: "販売可")
     	  @genres = Genre.where(is_deletes: false)


    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.order(created_at: :desc).where(is_active: "販売中").page(params[:page]).per(8)


    else
      @items = Item.where(is_active: "販売中").page(params[:page]).per(12)
    end
end

def thanks
end

def about
end

end

