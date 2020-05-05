class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs, :genre

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
       artist = Artist.new(name)
       artist.save
       artist
    end

    def save
        @@all << self
    end

    def add_song(song)
        song.artist = self unless song.artist
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        songs.collect {|song| song.genre}.uniq
    end

end