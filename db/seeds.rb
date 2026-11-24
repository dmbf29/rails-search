require "open-uri"
Movie.destroy_all
Director.destroy_all
TvShow.destroy_all


url = "https://gist.githubusercontent.com/dmbf29/f9aa96fa343be3947701099e76234e6b/raw/0f534b02568a0a023e70d57e7b3d22c7933ca802/imdb.yml"
sample = YAML.load(URI.parse(url).read)

puts "Creating directors..."
directors = {} # slug => Director
sample["directors"].each do |director|
  directors[director["slug"]] = Director.create!(director.slice("first_name", "last_name"))
end

puts "Creating movies..."
sample["movies"].each do |movie|
  Movie.create!(movie.slice("title", "year", "synopsis").merge(director: directors[movie["director_slug"]]))
end

puts "Creating TV shows..."
sample["tv_shows"].each { |tv_show| TvShow.create!(tv_show) }
puts "Done."
