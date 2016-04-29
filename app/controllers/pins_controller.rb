class PinsController < ApplicationController
	before_action :find_pin, only:[:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def show
	end

	def new
		@Pin = current_user.pins.build 
	end

	def create 
		@Pin = current_user.pins.build(pin_params)
	
		if @Pin.save
			redirect_to @Pin, notice: "success is yours well done"
		else
			render 'new'
		end
	end

		def edit
	end

	def update
		if @Pin.update(pin_params)
			redirect_to @Pin, notice: "successfully updated!"
		else
			render'edit'
		end
	end

	def destroy
		@Pin.destroy
		redirect_to root_path
	end

	def upvote
		@Pin.upvote_by current_user
		redirect_to :back
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end


	def find_pin
		@Pin = Pin.find(params[:id])
	end
end

