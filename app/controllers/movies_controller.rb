class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    # Establish the full set of ratings for the view
    @all_ratings = Movie.all_ratings

    # Extract incoming params
    params_ratings_keys = params[:ratings]&.keys
    params_sort_by = params[:sort_by]

    # If no params provided but we have session state, redirect to canonical URL with stored params
    if (params[:ratings].blank? && session[:ratings].present?) || (params[:sort_by].blank? && session[:sort_by].present?)
      redirect_to movies_path(ratings: session[:ratings], sort_by: session[:sort_by]) and return
    end

    # Compute ratings to show: default to all if none provided
    @ratings_to_show = if params_ratings_keys.present?
                         params_ratings_keys
                       else
                         @all_ratings
                       end

    # Persist current choices in session for later visits
    session[:ratings] = @ratings_to_show.index_with { |_r| "1" }
    session[:sort_by] = params_sort_by if params_sort_by.present?

    # Build the base relation using ratings filter
    @movies = Movie.with_ratings(@ratings_to_show)

    # Apply sort if provided and allowed
    if %w[title release_date].include?(params_sort_by)
      @sort_by = params_sort_by
      @movies = @movies.order(@sort_by)
    end
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, notice: "Movie was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
