class Song
	extend Concerns::Findable
	attr_accessor :name
	attr_reader :artist, :genre
	@@all = []

	def initialize(name, artist = nil, genre = nil)
    	@name = name
    	self.artist = artist if artist
    	self.genre = genre if genre
    end

	def save
		@@all << self
	end

	def self.all
		@@all
	end

	def self.destroy_all
		@@all = []
	end

	def self.create(song, artist = nil, genre = nil)
	    song = new(song, artist, genre)
	    song.save
	    song
	end

	def artist=(artist)
    	@artist = artist
    	artist.add_song(self) 
  	end

  	def genre=(genre)
  		@genre = genre
  		genre.add_song(self)
  	end

  	def self.new_from_filename(file)
        song_split = file.split(' - ')
        song = song_split[1]
        artist = Artist.find_or_create_by_name(song_split[0])
        genre = Genre.find_or_create_by_name(song_split[2].split('.')[0])
        self.create(song, artist, genre)

  	end

  	def self.create_from_filename(file)
        self.new_from_filename(file)
    end

end