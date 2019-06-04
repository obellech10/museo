class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(details)
    @id = details[:id]
    @name = details[:name]
    @artist_id = details[:artist_id].to_i
    @year = details[:year]
  end
end
