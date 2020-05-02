require 'pry'

class Artist 
  extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []

  def initialize(name)
    @name = name 
    @@all << self
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
  end 
  
  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

  def songs
    @songs
  end 

  def add_song(song)
    if song.artist == nil
        song.artist = self 
    end 
    @songs << song unless @songs.include?(song)
  end

  def genres
    @songs.map{ |song| song.genre }.uniq
  end

end