class MusicImporter
    attr_accessor :path, :files, :library

    def initialize(filepath)
        @path = filepath
        @files = Dir.entries(@path).select {|file| file.include?(".mp3")}
        @library = []
    end

    def import
        @files.each do |file|
            @library << Song.create_from_filename(file)
        end
    end

end