class SearchController < ApplicationController
  def feed_content
    @results = search_postgres_article

    @results = ArticleDecorator.decorate_collection(@results)
  end

  private

  def search_postgres_article
    Search::Article.search_documents(
      term: search_params[:q]
    )
  end

  def search_params
    params.permit(:class_name, :q)
  end
end
