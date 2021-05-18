class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create

    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:notice] = "Article was successfully created"
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  # Strong pararams
  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
end
