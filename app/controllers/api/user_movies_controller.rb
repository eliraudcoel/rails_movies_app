module Api
  module V1
    class Api::UserMoviesController < ApiController
      def show
        @user_movie = UserMovie.find(params[:id])

        # and check if user exist
        raise Exceptions::UserMovieNotFound unless @user_movie
      end
    end
  end
end
