class MusicLibraryController

#initialize the 'path' defaults to './db/mp3s'
#creates a new MusicImporter object, 
#passing the 'path' value
#invokes the #import method from MusicImporter
def initialize(path = './db/mp3s')
    getImport = MusicImporter.new(path)
    getImport.import
end

def call
    input = ''
    until input == 'exit' do
    puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artists'
        self.list_artists
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      else
        "ERROR"
      end
    end
    end

#1. Thundercat - For Love I Come - dance
#numbered list, alphabetized by song name       
#.each.with_index(1) start with 1
    def list_songs
        Song.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

#"1. Action Bronson"
#numbered list, alphabetized by artist name
    def list_artists
        Artist.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |artist, i|
        puts "#{i}. #{artist.name}"
        end
    end

#numbered list, alphabetized by genre name
    def list_genres
        Genre.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |genre, i|
        puts "#{i}. #{genre.name}"
        end
    end

#print songs/genre by a particular artist numbered list 
#alhabetized by song name
#"1. Green Aisles - country"
#does nothing if no matching artist is found
    def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
       artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end
  end

# print artist/songs by a particular genre in a numbered list 
#alphabetized by song name
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
    
        if genre = Genre.find_by_name(input)
          genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name}"
          end
        end
      end
    
#input = '5', play song 4. "Playing Larry Csonka by Action Bronson"
#strip remove white spaces
#chomp remove the newline character at the end of strings
#hecks if user entered between 1 and the total number of songs 
def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i - 1

    if input >= 1..Song.all.length 
    song = Song.all.sort { |a,b| a.name <=> b.name }[input]
        if song != nil
        puts "Playing #{song.name} by #{song.artist.name}" 
        end
    end
end

end
