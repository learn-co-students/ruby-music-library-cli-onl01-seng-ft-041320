class Genre
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  @@all = []
  def initialize(name)
    @name = name
    @songs = []
  end
  def self.destroy_all
    self.all.clear
  end
  def self.create(genre)
    genre = self.new(genre)
    genre.save
    genre
  end
  def songs
    @songs
  end
  def save
    @@all << self
  end
  def self.all
    @@all
  end
  def artists
    @new_array = []
    @songs.each do |song|
      if @new_array.include?(song.artist)
        nil
      else
        @new_array << song.artist
      end
    end
    @new_array
  end
end 
