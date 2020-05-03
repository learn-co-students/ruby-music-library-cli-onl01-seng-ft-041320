class MusicLibraryController
    def initialize (filepath = "./db/mp3s")
        MusicImporter.new(filepath).import
    end
    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        response = gets.strip
        until response == "exit"
            if response == "list songs"
                list_songs
            elsif response == "list artists"
                list_artists
            elsif response == "list genres"
                list_genres
            elsif response == "list artist"
                list_songs_by_artist
            elsif response == "list genre"
                list_songs_by_genre
            elsif response == "play song"
                play_song
            else
            end
            response = gets.strip
        end
    end

    def list_songs
        sorted = Song.all.sort {|a,b| a.name <=> b.name}
        sorted.each_with_index do |song,index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
        sorted
    end
    def list_artists
        sorted = Artist.all.sort {|a,b| a.name <=> b.name}
        sorted.each_with_index do |artist,index|
            puts "#{index+1}. #{artist.name}"
        end
    end
    def list_genres
        sorted = Genre.all.sort {|a,b| a.name <=> b.name}
        sorted.each_with_index do |genre,index|
            puts "#{index+1}. #{genre.name}"
        end
    end
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets.strip
        songs = Song.all.select{|song| song.artist.name == artist_name}
        sorted = songs.sort{|a,b| a.name <=> b.name}
        sorted.each_with_index do |song,index|
            puts "#{index+1}. #{song.name} - #{song.genre.name}"
        end
    end
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets.strip
        songs = Song.all.select{|song| song.genre.name == genre_name}
        sorted = songs.sort{|a,b| a.name <=> b.name}
        sorted.each_with_index do |song,index|
            puts "#{index+1}. #{song.artist.name} - #{song.name}"
        end
    end
    def play_song
        puts "Which song number would you like to play?"
        sorted = Song.all.sort {|a,b| a.name <=> b.name}
        number = gets.strip.to_i
        if number <= sorted.length && number > 0
            song = sorted[number.to_i-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end

    end
end