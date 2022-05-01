class ArticleImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @image = ArticleImage.new(image_params)

    if @image.save
      
      respond_to do |format|
        format.json { render json: { links: url_for(@image.article_image) }, status: :ok }
      end
    else
      puts @image.errors.full_messages

      respond_to do |format|
        format.json do
          render json: { error: "error has occurred!" }, status: :unprocessable_entity
        end
      end
      
    end
  end

  private

  def image_params
    {
      article_image: params[:image],
      filename: params[:image].original_filename
    }
  end

end
