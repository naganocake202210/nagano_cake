class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
  end

  def about
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end
end
