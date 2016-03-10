require 'sinatra'
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
	@songs = songs
	erb :index
end

get '/songs/new' do
	erb :new
end

get '/songs/:id' do
	id = params[:id].to_i
	@song = songs[id]
	erb :show
end

post '/songs' do
	new_song = params[:song]
	songs.push(new_song)
	redirect '/songs'
end