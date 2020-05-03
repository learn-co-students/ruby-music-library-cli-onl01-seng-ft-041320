require 'pry'
require_relative '../config/environment'

song = Song.new_from_filename("Thundercat - For Love I Come - dance.mp3")

binding.pry