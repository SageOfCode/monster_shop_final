class Merchant::DiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end 

  def new
    @merchant = Merchant.find(current_user.merchant_id)
    @discount = Discount.new
  end

  def create 
    @merchant = current_user.merchant
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to "/merchant/#{@merchant.id}/discounts/index"
    else
      flash[:notice] = "Please select a percentage between 0 and 1, and a item requirement greater than 0"
      render :new
    end 
  end 

  def edit 
    @discount = Discount.find(params[:discount_id])
    @merchant = @discount.merchant
  end

  def update
    discount = Discount.find(params[:discount_id])
    discount.update(discount_params)
    merchant = discount.merchant
     if discount.save
      redirect_to "/merchant/#{merchant.id}/discounts/index"
    else
      flash[:notice] = "Please select a percentage between 0 and 1, and a item requirement greater than 0"
      render :new
    end 
  end

  def delete 
    discount = Discount.find(params[:discount_id])
    merchant = discount.merchant
    Discount.destroy(params[:discount_id])
    redirect_to "/merchant/#{merchant.id}/discounts/index"
  end

  private

  def discount_params
    params[:discount].permit(:percent_off, :item_requirement)
  end
end 