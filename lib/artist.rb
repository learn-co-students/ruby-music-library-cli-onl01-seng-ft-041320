class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs, :genre 

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    @name = self.new(name)
    @name.save
    return @name
  end
  
  def add_song(song)
    @songs << song unless songs.include?(song)
    if song.artist == nil
      song.artist = self
    end
  end
  
  def genres 
    self.songs.collect{|song| song.genre}.uniq
  end

end