class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_article, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @user = current_user

    if @user.nil? || !@user.admin?
      # flash[:error] = "글을 작성하실 수 없습니다."
      redirect_to root_path
    end
    @article = Articles::Builder.call(@user)
  end

  def edit
    authorize @article
  end

  def create
    # @article = Article.new(article_params)
    @user = current_user
    @article = Articles::Creator.call(@user, article_params)

    respond_to do |format|
      if @article.persisted?
        format.html { redirect_to @article.decorate.current_state_path, notice: 'article was successfully created.' }
        format.json { render :show, status: :created, location: @article.decorate.current_state_path }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = @article.user || current_user

    result = Articles::Updater.call(@user, @article, article_params)

    respond_to do |format|
      if result
        format.html { redirect_to @article.decorate.current_state_path, notice: 'article was successfully updated.' }
        format.json { render :show, status: :updated, location: @article.decorate.current_state_path }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
  
  def set_article
    # @article = Article.find(params[:id])
    author = User.find_by(username: params[:username])
    found_article = if author && params[:slug]
                      author.articles.find_by(slug: params[:slug])
                    else
                      Article.find(params[:id])
                    end
    @article = found_article || not_found
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:body_markdown)
  end
end
