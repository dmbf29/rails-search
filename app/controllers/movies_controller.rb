class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # This is looking for an EXACT match
      @movies = Movie.where(title: params[:query])
      # We want to search for it anywhere in the title, case insensitive
      # @movies = Movie.where('title ILIKE ?', "%#{params[:query]}%")
      # We want to search for the title AND synopsis
      # @movies = Movie.where('title ILIKE ? OR synopsis ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
      # The dry version of the one above ☝️
      # @movies = Movie.where('title ILIKE :query OR synopsis ILIKE :query', query: "%#{params[:query]}%")
      # We want to look into another table as well
      # @movies = Movie.joins(:director).where(
      #   'title ILIKE :query
      #   OR synopsis ILIKE :query
      #   OR first_name ILIKE :query
      #   OR last_name ILIKE :query',
      #   query: "%#{params[:query]}%"
      # )
      @movies = Movie.search(params[:query])
    else
      @movies = Movie.all
    end
  end
end
