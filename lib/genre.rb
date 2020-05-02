require_relative '../concerns/concerns.rb'

class Genre
    
    extend Concerns::Findable

    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        self.class.all.push(self)
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        new_inst = self.new(name)
        new_inst.save
        new_inst
    end

    def add_song(song)
        return if songs.include?(song)
        songs.push(song)
        #song.genre = self
    end

    def artists
        songs.map {|song| song.artist}.uniq
    end

end