require 'pry'

class Song 
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre
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
    Song.new(name).save
  end
  
  def artist=(artist)
    @artist = artist #Why do we need to put this to avoid a loop??
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre #Why do we need to put this to avoid a loop??
    genre.add_song(self)
  end
  
  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end 
    
  def self.new_from_filename(filename) #"Thundercat - For Love I Come - dance.mp3"
    artist, song, genre = filename.chomp(".mp3").split(" - ")
    new_artist = Artist.find_or_create_by_name(artist)
    new_genre = Genre.find_or_create_by_name(genre)
    new(song, new_artist, new_genre)
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
  
end
