class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:success] = "Article was successfully created"
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was deleted successfully"
    redirect_to articles_path
  end

  # Strong pararams
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end
end
