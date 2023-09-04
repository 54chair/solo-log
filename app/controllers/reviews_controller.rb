class ReviewsController < ApplicationController
  
  def new
    @shop = Shop.find(params[:shop_id])
    @review = @shop.reviews.build
  end
  
  def create
    @review = Review.new(review_params)
    # もしcurrent_userがいなければ、review.userはnil
    @review.user = current_user
    if @review.save
      flash[:notice] = "作成できました"
      redirect_to @review.shop
    else
      flash[:alert] = "作成できませんでした"
      render 'new'
    end
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  #def destroy
  #end

  private

  def review_params
    params.require(:review).permit(:rate, :comment, :counter_sheets_available,
                                   :frequent_solo_visitors, :solo_tables_available,
                                   :easy_to_order, :delivery_speed, :calmness)
  end
end