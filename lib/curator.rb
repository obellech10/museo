class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(artist_id)
    @artists.find do |artist|
      artist if artist.id == artist_id
    end
  end

  def find_photograph_by_id(photo_id)
    @photographs.find do |photo|
      photo if photo.id == photo_id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      artist.id.to_i == photo.artist_id
    end
  end

  def artists_with_multiple_photographs
    multi_photo_artist = []
    photo_count = Hash.new(0)
    @photographs.each do |photo|
      photo_count[photo.artist_id] += 1
    end
    photo_count.each do |id, count|
      if count > 1
        @artists.find do |artist|
          multi_photo_artist << artist if artist.id.to_i == id
        end
      end
    end
    multi_photo_artist
  end

end
