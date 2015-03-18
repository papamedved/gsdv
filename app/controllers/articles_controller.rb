class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    @article.save
    #render plain: @article.inspect
    redirect_to @article
  end

  def show
    if params[:id] == 'user'
      user
    else
      @article = Article.find(params[:id])
    end
  end

  def user
    #render plain:  current_user.id
    user_id = current_user.id
    @articles = Article.where(:user_id => user_id)

    @articles.each do|all|
      all.text = all.text.truncate(600)
    end

    render :action => 'user'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to article_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :user_id)
    end
end
