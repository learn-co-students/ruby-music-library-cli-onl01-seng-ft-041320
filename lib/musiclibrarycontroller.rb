class MusicLibraryController
    attr_accessor :importer

    def initialize(filepath="./db/mp3s")
        @importer = MusicImporter.new(filepath)
        @importer.import
    end

    def call()
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        user_input = ""
        while (user_input != "exit")
            user_input = gets().strip()

            if user_input == "list songs"
                list_songs
            elsif user_input == "list artists"
                list_artists
            elsif user_input == "list genres"
                list_genres
            elsif user_input == "list artist"
                list_songs_by_artist
            elsif user_input == "list genre"
                list_songs_by_genre
            elsif user_input == "play song"
                play_song
            end
        end

    end

    def list_songs
        sorted_songs = @importer.library.sort {|a, b| a.name <=> b.name}
        sorted_songs.each do |song|
            puts "#{sorted_songs.index(song)+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        sorted_songs = @importer.library.sort {|a, b| a.name <=> b.name}

        unique_artists = []
        sorted_songs.each do |song|
            unique_artists << song.artist if !(unique_artists.include?(song.artist))
        end

        unique_artists = unique_artists.sort {|a, b| a.name <=> b.name}

        unique_artists.each do |artist|
            puts "#{unique_artists.index(artist)+1}. #{artist.name}"
            #binding.pry
        end
    end

    def list_genres
        sorted_songs = @importer.library.sort {|a, b| a.name <=> b.name}

        unique_genres = []
        sorted_songs.each do |song|
            unique_genres << song.genre if !(unique_genres.include?(song.genre))
        end

        unique_genres = unique_genres.sort {|a, b| a.name <=> b.name}

        unique_genres.each do |genre|
            puts "#{unique_genres.index(genre)+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"

        user_input = gets.strip
        

        if artist = Artist.find_by_name(user_input)
            songs = Song.all.select {|song| song.artist == artist}
            #binding.pry
            songs = songs.sort {|a, b| a.name <=> b.name}
            songs.each do |song|
                puts "#{songs.index(song)+1}. #{song.name} - #{song.genre.name}"
            end
        end
        '''
        artist_songs = artist.songs.sort {|a, b| a.name <=> b.name}
        
        
        artist_songs.each do |song|
            puts "#{artist_songs.index(song)+1}. #{song.name} - #{song.genre}"
        end
        '''
        

    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.strip

        if genre = Genre.find_by_name(user_input)
            songs = Song.all.select {|song| song.genre == genre}
            #binding.pry
            songs = songs.sort {|a, b| a.name <=> b.name}
            songs.each do |song|
                puts "#{songs.index(song)+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.strip.to_i

        songs = @importer.library.sort {|a, b| a.name <=> b.name}

        if user_input >= 1 && user_input <= songs.size
            puts "Playing #{songs[user_input - 1].name} by #{songs[user_input - 1].artist.name}"
        end
    end
end