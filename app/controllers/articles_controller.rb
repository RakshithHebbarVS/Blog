class ArticlesController < ApplicationController
	before_action :authenticate_user!

	def index
		@article = Article.all
	end
	def new 
		@article = Article.new 
	end

	def create
		@article = Article.new(article_param)
		@article.user_id = current_user.id
		#@article.published_on = DateTime.now
		if @article.save
			redirect_to articles_path , notice: "Successfully created article"
		else
			render action:"new"
		end
	end

	def show
	begin
	  @article = Article.find(params[:id])
	  @comments = @article.comments
	  @comment = Comment.new
	rescue ActiveRecord::RecordNotFound
		redirect_to articles_path, notice:"Record Not Found"
	end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(article_param)
			redirect_to article_path(@article), notice: "Successfully updated"
		else
			render action: "edit"
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@comments = @article.comments
		@comments.destroy_all
		@article.destroy
		redirect_to articles_path
	end

	def my_articles
		@myarticles = Article.where('user_id=?',current_user.id)
	end

	private

	def article_param
		params[:article].permit(:title, :body, category_ids: [])
	end


end
