class Artist
  attr_accessor :name, :songs, :genres

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
    song.artist = self if song.artist.nil?
  end

  def genres
    songs.collect { |song| song.genre }.uniq
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end
end
