class Genre 
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
    Genre.new(name).save
  end
  
  def songs 
    @songs
  end
  
  def add_song(song)
    song.genre = self unless song.genre
    @songs << song unless songs.include?(song) || song.genre != self
  end
  
  def artists
    @songs.each.collect {|song| song.artist}.uniq
  end
  
end
