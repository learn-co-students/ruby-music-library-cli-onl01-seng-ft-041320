class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        Dir.entries(@path).select {|file| file.include? (".mp3")}
        #files = Dir.glob(path+"/*.mp3").map {|f| f.gsub(path+"/", "") }
    end

    def import 
        files.each { |filename| Song.create_from_filename(filename)}
    end



end
