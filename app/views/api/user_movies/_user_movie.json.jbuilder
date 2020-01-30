# Make movie: { ... }
# json.movie user_movie.movie

# Movie attributes => directly in json
json.id user_movie.id
json.imdbID user_movie.movie.imdbID
json.title user_movie.movie.title
json.overview user_movie.movie.overview
json.poster_path user_movie.movie.poster_path
json.backdrop_path user_movie.movie.backdrop_path
json.vote_average user_movie.movie.vote_average
json.release_date user_movie.movie.release_date

# user_movie extract
json.extract! user_movie, :favorite, :rate