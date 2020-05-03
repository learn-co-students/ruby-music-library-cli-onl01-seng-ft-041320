class Song
    extend Concerns::Findable
    @@all = []

    attr_accessor :name, :genre
    attr_reader :artist

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist)
        self.genre=(genre)
        save
    end

    def save
        @@all << self
    end

    '''
    def artist
        @artist
    end
    '''

    def artist=(new_artist)
        
        @artist = new_artist
        @artist.add_song(self) if !(artist.nil?)
    end

    def genre=(genre)
        if !genre.nil?
            @genre = genre
            genre.songs << self if !(genre.songs.include?(self))
        end

    end

    def self.create(name)
        self.new(name)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def self.new_from_filename(filename)
        new_song = self.new( filename.split(" - ")[1], 
                             Artist.find_or_create_by_name(filename.split(" - ")[0]),
                             Genre.find_or_create_by_name(filename.split(" - ")[2].chomp(".mp3")) )
        
        new_song.artist.add_song(new_song)

        new_song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end

end