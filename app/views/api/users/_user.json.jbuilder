json.extract! user, :id, :email
json.access_token access_token if access_token

# get movies
#json.movies user.movies if user.movies

json.movies @user.user_movies, partial: "api/user_movies/user_movie", as: :user_movie
