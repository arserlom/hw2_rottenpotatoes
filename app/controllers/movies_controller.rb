class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    #session.delete(:selected_ratings)
    #debugger
    if params[:ratings] == nil
      redirect_to movies_path({:ratings => session[:selected_ratings] || Movie.ratings_hash})
      return
    else
      @selected_ratings = params[:ratings].keys
    end
    selected_ratings_hash = {}
    @selected_ratings.each {|r| selected_ratings_hash[r] = '1'}
    session[:selected_ratings] = selected_ratings_hash
    @movies = Movie.all(:conditions => ["rating in (?)", @selected_ratings], :order => params[:sort_by] || "id")
    
    @title_class = 'no_hilite'
    @release_date_class = 'no_hilite'
    if params[:sort_by] == 'title'
      @title_class = 'hilite'
    end
    if params[:sort_by] == 'release_date'
      @release_date_class = 'hilite'
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
