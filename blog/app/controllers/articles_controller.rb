class ArticlesController < ApplicationController

  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    ensure_logged_in
    @articles = Article.all
  end

  def show
    ensure_logged_in
    @article = Article.find(params[:id])
  end

  def new
    ensure_logged_in
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(title: params[:article][:title], text: params[:article][:text], creator: current_user) # How to use article_params here?

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(title: params[:article][:title], text: params[:article][:text], creator: current_user) # How to use article_params here?
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
