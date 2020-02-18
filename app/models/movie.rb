class Movie < ApplicationRecord
    has_many :user_movies
    has_many :users, through: :user_movies

    validates :imdbID, uniqueness: true
    validates :title, uniqueness: true
end
