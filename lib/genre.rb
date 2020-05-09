class Genre 
  extend Concerns::Findable
  attr_accessor :name
  
  @@all = []
  
def initialize(name)
  @name = name
  @songs = []
  save
end

def save
  @@all << self
end

def self.all
  @@all
end

def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    @name = self.new(name)
    @name.save
    return @name
  end
  
def songs
  @songs 
end

def artists
    self.songs.collect {|song| song.artist}.uniq
  end

end 