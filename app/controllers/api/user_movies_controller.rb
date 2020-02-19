module Api
  module V1
    class Api::UserMoviesController < ApiController

      # Skip verify_authenticity_token
      # Error display : Can't verify CSRF token authenticity
      # Fix Reference : https://stackoverflow.com/a/43122403
      skip_before_action :verify_authenticity_token, only: [:update, :create]

      def show
        @user_movie = UserMovie.find(user_movie_params[:id])

        # and check if user_movie exist
        raise Exceptions::UserMovieNotFound unless @user_movie
      end

      def create
        user_movies = @current_user.movies

        @movie = user_movies.find_by(imdbID: user_movie_params[:imdbID])

        unless @movie
          @movie = Movie.create(user_movie_params)
        end

        @user_movie = @current_user.user_movies.create(update_params.merge({movie: @movie}))

        # and check if user_movie exist
        # raise Exceptions::UserMovieNotFound unless @user_movie
      end

      def update
        @user_movie = UserMovie.find(user_movie_params[:id])

        @user_movie.update(update_params)

        # and check if user_movie exist
        raise Exceptions::UserMovieNotFound unless @user_movie
      end

      private

      def user_movie_params
        params.permit(:id, :imdbID, :title, :overview, :poster_path, :backdrop_path, :vote_average, :release_date)
      end

      def update_params
        params.permit(:favorite, :rate)
      end
    end
  end
end
