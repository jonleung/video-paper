require 'rubygems'
require 'sinatra'
require 'sinatra/respond_with'

require 'data_mapper' # metagem, requires common plugins too.

require 'streamio-ffmpeg'

require 'open-uri'
require 'httparty'

if development?
  require 'sinatra/reloader' if development?
  require 'byebug'
end

require_relative "video"
require_relative "twilio"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/video_paper.db")
DataMapper.finalize
Video.auto_upgrade!

def dweet(video)
  options = { 
    audio_url: video.audio_path,
    image_url: video.image_path
  }

  response = HTTParty.get('http://dweet.io/dweet/for/jonathan_leung', query: options)                
end

post '/videos' do
  url = params['MediaUrl0']

  $twilio.messages.create(
    from: '+1-484-685-0584',
    to: params["From"],
    body: 'Awesome, just got your video, give us a sec while we process it!'
  )

  video_params = { phone: params["From"] }
  
  video = Video.download_and_create(url, video_params)

  movie = FFMPEG::Movie.new(video.video_path)
  movie.transcode(video.audio_path, :ab => 128)
  movie.screenshot(video.image_path) #TODO fix rotation

  response = dweet(video)

  $twilio.messages.create(
    from: '+1-484-685-0584',
    to: params["From"],
    body: 'Alright your video is processed and should be coming out of the printer soon!'
  )

  response.to_json
end

get '/videos/:id.?:format?' do
  id = params[:id]
  video = Video.get(id)

  case params[:format]
  
  when "mp3"
    content_type :mp3
    File.read(video.audio_path)
  
  when "jpg"
    content_type :jpg
    File.read(video.image_path)
  end
end

get '/printer' do
  erb :printer
end

get '/scanner' do
  erb :scanner
end

get '/' do
  erb :index
end