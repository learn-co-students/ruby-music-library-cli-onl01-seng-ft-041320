require 'pry'

class Song 
    attr_accessor :name, :artists
    attr_reader :artist, :genre
    @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
   end

  def artist=(artist)
   @artist = artist
   artist.add_song(self)
  end

  def self.all
    @@all 
  end 

  def self.destroy_all 
    @@all.clear
  end 

  def save
  @@all << self
  end 
  
  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def self.find_by_name(name)
  @@all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end 
  end 
  
  def self.new_from_filename(file) 
    artist, song, genre = file.gsub(".mp3","").split(" - ")
    new_artist = Artist.find_or_create_by_name(artist)
    new_genre = Genre.find_or_create_by_name(genre)
    self.new(song, new_artist, new_genre)
  end
  
  def self.create_from_filename(file)
    self.new_from_filename(file).save
  end
end