class CategoriesController < ApplicationController
	def index 
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_param)
		if @category.save
			redirect_to categories_path
		else
			render action: "new"
		end
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_param)
			redirect_to categories_path, notice: "Successfully updated"
		else
			render action: "edit"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path
	end



	private

	def category_param
		params[:category].permit(:name)
	end

end
