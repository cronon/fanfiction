class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  impressionist :actions=>[:index,:show]

  #POST /books/1/like
  def like
    @book=Book.where(:id => params[:id]).first
    @book.liked_by current_user
    respond_to do |format|
      format.js
    end
    #redirect_to root_url
  end

  # GET /books
  # GET /books.json
  def index

    if params[:search]
      @books = Book.search(Riddle.escape(params[:search]))
      if @books.empty?
        redirect_to root_url, notice: 'There is no search results'
      end
    elsif params[:tag]
      @books = Book.tagged_with(params[:tag]).paginate(page: params[:page], per_page: items_per_page)
    elsif params[:category]
      @books = Book.where(:category => params[:category]).paginate(page: params[:page], per_page: items_per_page)
    else
      @books = Book.paginate(page: params[:page], per_page: items_per_page)
    end
    #current_ability
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @widget = Book.find(params[:id])
    impressionist(@widget,message:"wtf is a widget?")
    @chapters=@book.chapters
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.js 
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :tag_list)
    end
end
