class Song
    attr_accessor :name
    attr_reader :artist, :genre

@@all = []

def initialize(name,artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
#returns the genre of the song (song belongs to genre
    self.genre = genre if genre
end

#assigns a genre to the song (song belongs to genre)
#adds the song to the genre's collection of songs 
#(genre has many songs)
def genre=(genre)
    @genre = genre
    genre.add_song(self) 
  end

#invokes Artist#add_song to add itself to the artist's 
#collection of songs (artist has many songs)
def artist=(artist)
    @artist = artist
    artist.add_song(self) 
  end

  def save
    @@all << self
  end 

def self.all
    @@all
end

def self.destroy_all 
    @@all.clear
end

def self.create(name)
    song = new(name)
    song.save
    song
end

#finds a song instance in @@all by the name property
def self.find_by_name(name)
  @@all.detect {|find| find.name == name}
end

#returns an existing song with the provided name
def self.find_or_create_by_name(name)
   self.find_by_name(name) || self.create(name)
end

#"Thundercat - For Love I Come - dance.mp3"
#initializes a song based on the passed-in filename
#invokes Findable methods avoid duplicating objects
#def initialize(name,artist = nil, genre = nil)
def self.new_from_filename(filename)
  a_name,s_name,g_name = filename.split(" - ")
  g_name = g_name.gsub(".mp3", "")
  
  artist = Artist.find_or_create_by_name(a_name)
  genre = Genre.find_or_create_by_name(g_name)
   new(s_name, artist, genre)
end

#initializes and saves a song based on the passed-in filename
#invokes .new_from_filename instead of re-coding the same functionality
#.tap Yields self to the block, and then returns self
def self.create_from_filename(filename)
  new_from_filename(filename).tap{|file| file.save }
end
end