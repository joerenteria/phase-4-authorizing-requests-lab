class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authorize

  def index
    articles = Article.all

    render json: articles

  end

  def show
    article = Article.find(params[:id])

    if is_member_only = true
    render json: article
    else
      render json: {error: "Unauthorized"} , status: 401
    end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user
  end

end
