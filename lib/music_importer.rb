class MusicImporter
    
    attr_accessor :path

    def initialize(file_path)
        @path = file_path
    end

    def import
        file_names = Dir.glob("#{path}/*.mp3").select{ |f| File.file? f }.map{ |f| File.basename f }
        file_names.each do |file_name|
            Song.create_from_filename(file_name)
        end
    end

    def files
        file_names = Dir.glob("#{path}/*.mp3").select{ |f| File.file? f }.map{ |f| File.basename f }
    end
end