class Genre
  attr_accessor :name, :songs, :artists

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    self.name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.genre = self if song.genre.nil?
  end

  def artists
    songs.collect { |song| song.artist }.uniq
  end

  def self.create(name)
    genre = new(name)
    genre.save
    genre
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end
end
