require 'pry'
class MusicLibraryController
    
    def initialize(path ="./db/mp3s")
        @path = path
        import_music = MusicImporter.new(path)
        import_music.import
    end

    def call
        #Welcome User
        input = ""
        while (input != 'exit')
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.strip
            case input
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
            else
            
            end
        end
    end

    def list_songs
        #prints all songs in the music library in a numbered list
        #is not hard coded

        Song.all.sort_by{|song| song.name}.each_with_index do|song, index|
            # binding.pry
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort_by{|artist| artist.name}.each_with_index do|artist, index|
            # binding.pry
            puts "#{index+1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort_by{|genre| genre.name}.each_with_index do|genre, index|
            # binding.pry
            puts "#{index+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        Song.all.select{|song| song.artist.name == input}.sort_by{|song| song.name}.each_with_index do|song, index|
            puts "#{index+1}. #{song.name} - #{song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        Song.all.select{|song| song.genre.name == input}.sort_by{|song| song.name}.each_with_index do|song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        # self.list_songs
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        available_songs = Song.all.sort_by{|song| song.name}
        # binding.pry
        if input > 0 && input <= available_songs.length
            index = input - 1 
            puts "Playing #{available_songs[index].name} by #{available_songs[index].artist.name}"

        end
    end
end
