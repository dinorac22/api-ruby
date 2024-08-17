module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: %i[show update destroy]

      #GET api/v1/products
      def index        
        @products = Product.all
        render json: {listProducts:@products}
      end

      #POST api/v1/products
      def create
        @product = Product.new(product_params)
        if @product.save
          render json: { message: 'Product added successfully', data: @product }
        else
          render json: { message: 'Failed to add product', data: @product.errors }
        end
      end

      #GET api/v1/products/:id
      def show
        
        if @product
          render json: { message: 'Product found', data: @product }
        else
          render json: { message: 'Product not found', data: @product.errors }
        end
      end

      #PATCH/PUT api/v1/products/:id
      def update
        
        if @product.update(product_params)
          render json: { message: 'Product updated successfully', data: @product }
        else
          render json: { message: 'Failed to update product', data: @product.errors }
        end
      end

      #DELETE api/v1/products/:id
      def destroy
        
        if @product.destroy
          render json: { message: 'Product deleted successfully', data: @product }
        else
          render json: { message: 'Failed to delete product', data: @product.errors }
        end
      end

      private
      def set_product
          @product = Product.find(params[:id])
      end 

      def product_params
        params.require(:product).permit(:name, :description, :price)
      end


    end
  end
end