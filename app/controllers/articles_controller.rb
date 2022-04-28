class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # @article = Article.new(article_params)
    @user = current_user
    @article = Articles::Creator.call(@user, article_params)

    respond_to do |format|
      if @article.persisted?
        format.html { redirect_to @article, notice: 'article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body_markdown)
  end
end
