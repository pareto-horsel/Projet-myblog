class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  #l'action index permet de recuperer tous les articles
  def index
    @articles = Article.all 
  end
  #l'action show permet de consulter une resource deja creer 
  def show 
    @article = Article.find (params[:id])
  end
  #l'action new permet d'afficher un formulaire permettant de creer une nouvelle resource
  def new
    @article = Article.new     
  end
  #l'action create permet de creer une nouvelle resource dans la base de donnée
  def create 
    @article = Article.new(article_params)
    #@article.user_id = current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end
   #edit cette action est utilisé pour afficher un formulaire qui permet de modifier une resource existante 
  def edit 
    @article =Article.find(params[:id])
  end
  #L'action update est utilisé pour mettre à jour une resource existante dans la base de données
  def update 
    @article =Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to articles_path(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end
  #destroy cette action permet de detruire une resource existante dans la base de données
  def destroy 
    @article = Article.find(params[:id])
    @article.destroy!
    respond_to do |format|
      format.html { redirect_to article_path, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end  
  end 
  private

    def set_article
      @article = Article.find(params[:id])
    end
    def article_params 
      params.require(:article).permit(:title, :body, :status)
    end
end
