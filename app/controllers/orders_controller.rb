class OrdersController < PanelController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :set_restaurant, only: %i[index create]
  before_action :set_new_order, only: %i[create]

  skip_before_action :authenticate_user!, only: %i[create]
  skip_before_action :set_restaurants, only: %i[create]
  # GET /orders
  # GET /orders.json
  def index
    @orders = @restaurant.orders.where(state: Order::PRE_DELIVERED_STATES).includes(:order_items, :items)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders
  # POST /orders.json
  def create
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: { order_id: @order.id }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_new_order
    @order = @restaurant.orders.new(order_params)
    params['cart'].permit!
    params['cart'].to_h.each do |item_id, quantity|
      @order.order_items.new(item_id: item_id, quantity: quantity)
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id] || params['restaurant_id'])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:from, :note, :address, :cart)
  end
end
