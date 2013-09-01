class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_filter :load_book

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.where(:book_id => @book.id).paginate(page: params[:page], per_page: chapters_per_page)
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @chapter = @book.chapters.where(:id => params[:id]).first
  end

  # GET /chapters/new
  def new
    @chapter = @book.chapters.new
  end

  # GET /chapters/1/edit
  def edit
    @chapter=@book.chapters.where(:id => params[:id]).first
  end

  # POST /chapters
  # POST /chapters.json
  def create
    #@chapter.book_id = params[:chapter].book_id =params[:book_id]
    #@chapter = @book.chapters.new(params[:chapter]) #.merge :book_id => params[:book_id]
    @chapter = @book.chapters.new(chapter_params)
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to [@book,@chapter], notice: 'Chapter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chapter }
      else
        format.html { render action: 'new' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    @chapter = @book.chapters.where(:id => params[:id]).first
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to [@book,@chapter], notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter = @book.chapters.where(:id => params[:id]).first 
    @chapter.destroy                            
    respond_to do |format|                      
      format.html { redirect_to book_chapters_path(@book) } 
      format.js        
      format.json { head :no_content }               
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :content)
    end

    def load_book
      @book = Book.find(params[:book_id])
    end
end
