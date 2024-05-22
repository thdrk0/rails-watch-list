require 'net/http'
require 'uri'
require 'json'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
uri = URI.parse("https://tmdb.lewagon.com/movie/top_rated")
response = Net::HTTP.get_response(uri)
data = JSON.parse(response.body)
results = data["results"]

puts 'Cleaning database...'
Movie.destroy_all
List.destroy_all

puts 'Creating movies...'
results.each do |details|
  poster = "https://image.tmdb.org/t/p#{details['backdrop_path']}"
  movie = Movie.create(title: details['original_title'],
                      overview: details['overview'],
                      poster_url: poster,
                      rating: details['vote_average'] )
  puts "Created #{movie.title}"
end

puts ''
puts ''
puts ''

puts 'Creating lists...'
10.times do
  list = List.create(name: Faker::Name.name)
  puts "Created #{list.name}"
end
puts "Finished!"
