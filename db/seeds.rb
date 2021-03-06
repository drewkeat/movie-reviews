# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

movies = [
    "Star Wars",
    "Lord of the Rings",
    "Batman",
    "Superman",
    "X-Men",
    "The Notebook",
    "Love Actually",
    "Die Hard",
    "Memento"
]

    def request_movie(movie_title)
        request = RestClient.get "http://www.omdbapi.com/?apikey=c01df668&t=#{movie_title}&plot=full"
        api_hash = JSON.parse(request)
    end

    def create_movie(movie_title)
        api_hash = request_movie(movie_title)
        attributes = {}
        attributes[:title] = api_hash["Title"]
        attributes[:year] = api_hash["Year"]
        attributes[:rating] = api_hash["Rated"]
        attributes[:release_date] = api_hash["Released"]
        attributes[:runtime] = api_hash["Runtime"]
        attributes[:genre] = api_hash["Genre"]
        attributes[:plot] = api_hash["Plot"]
        attributes[:awards] = api_hash["Awards"]
        attributes[:poster_url] = api_hash["Poster"]
        Movie.create(attributes)
    end

    movies.each {|movie| create_movie(movie)}
