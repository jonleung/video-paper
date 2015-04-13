class Video
  include DataMapper::Resource
  property :id, Serial
  property :phone, String
  property :created_at, DateTime

  def audio_path
    "videos/#{self.id}.mp3"
  end

  def image_path
    "videos/#{self.id}.jpg"
  end

  def video_path
    "videos/#{self.id}.mov"
  end

  class << self

    def download_and_create(url, params)
      video = Video.create(params)
      open(video.video_path, 'wb') do |file|
        file << open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
      end

      return video
    end

  end

end