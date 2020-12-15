class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:new, :create, :edit, :update, :delete]
  before_action :redirect_user_if_no_article, only: [:edit, :update, :delete]


  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = @current_user
    respond_to do |format|
      if @article.save
          @current_user.ranking.point += 1
          @current_user.ranking.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article.user = @current_user
    respond_to do |format|
      if @article.update(article_params)
          @current_user.ranking.point += 0.5
          @current_user.ranking.save
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def authorize_user
      if @current_user.nil?
        redirect_to sign_in_path
      end
    end
  
    def redirect_user_if_no_article
      if @article.nil? || @current_user.id != @article.user.id
        redirect_to articles_path
      end
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:content)
    end
end
