byebug
json.extract! user,
            :id,
            :email,

json.access_token access_token if access_token
# TODO
# json.movies user.movies
