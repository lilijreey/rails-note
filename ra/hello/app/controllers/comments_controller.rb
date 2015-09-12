class CommentsController < ApplicationController
  before_action :authorize, only: [:destroy]


  def others
    others = params.permit(:others)
    respond_to do |f|
      f.html {render html: others}
    end

  end
  def aabbcc
    xx = params.permit(:bb, :cc)
    respond_to do |f|
      f.html {render html: xx}
      f.json{render json: xx}
      f.any # {render json: xx}
    end
    
  end

  def create
    @article = Article.find(params[:article_id])
    ## comment 是个嵌套资源，在路由路径中肯定有 article 的信息
    if not @article
      redirect_to @article, alert: 'Bad request'
      return
    end

    @Comment = @article.comments.new(params_comment())
    if @Comment.save
      redirect_to @article, notice: 'Thanks for your comment'
    else
      redirect_to @article, alert: 'Unable to add comment'
    end
  end

  def destroy
    @article = current_user.articles.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to @article, notice: 'Comment deleted'
  end

  private
  def params_comment
    params.require(:comment).permit(:name, :email, :body)
  end
end
