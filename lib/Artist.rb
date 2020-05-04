

class Artist
  extend Concerns::Findable
  attr_accessor :name
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all 
    @@all.clear
  end
  
  def save
    @@all << self 
    self
  end
  
  def self.create(name)
    Artist.new(name).save
  end
  
  def songs
    @songs
  end
  
  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless songs.include?(song) || song.artist != self
  end
  
  def genres
    @songs.each.collect {|song| song.genre}.uniq
  end
  
end
