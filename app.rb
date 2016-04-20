require 'sinatra'
require "json"
require "typhoeus"

songs = [
		{title: "My Way", year: 1969, url: "https://www.youtube.com/embed/5AVOpNR2PIs"},
		{title: "That's Life", year: 1969, url: "https://www.youtube.com/embed/KIiUqfxFttM"},
		{title: "Come Fly With Me", year: 1969, url: "https://www.youtube.com/embed/Euci0_BBmNE"},
		{title: "Luck Be A Lady", year: 1969, url: "https://www.youtube.com/embed/QIfinjlLPF4"},
		{title: "The Way You Look Tonight", year: 1969, url: "https://www.youtube.com/embed/h9ZGKALMMuc"},
		{title: "Fly Me To The Moon", year: 1969, url: "https://www.youtube.com/embed/mQR0bXO_yI8"}
	]

get '/' do
    erb :home
end

get '/about' do
  "This is our first sinatra app!"
end

get '/songs' do
	if params[:artist]
		search = params[:artist].gsub(/\s/,'+')
	else
		search = "frank+sinatra"
	end
	res = Typhoeus.get "https://itunes.apple.com/search?term=#{search}&&entity=album&limit=5"
	parsed = JSON.parse res.body
	@data = parsed["results"]
	@songs = parsed["results"]
	erb :index
end

get '/songs/new' do
	erb :new
end


get '/songs/:id' do
	id = params[:id]
	res = Typhoeus.get "http://itunes.apple.com/lookup?id=#{id}&entity=song"
	parsed = JSON.parse res.body
	@songs = parsed["results"]
	@album = @songs.shift
	erb :show
end

post '/songs' do
	new_song = params[:song]
	songs.push(new_song)
	redirect '/songs'
end