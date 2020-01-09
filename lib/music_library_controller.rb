require 'pry'
class MusicLibraryController
  attr_reader :path

  def initialize(path = "./db/mp3s")
    @path = path
    music = MusicImporter.new(@path)
    music.import
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

    input = gets.strip
    if input == "exit"
      return
    else
      call
    end
  end

  def list_songs
    list = Song.all.sort {|a, b| a.name <=> b.name}.uniq
    count = 1
    list.each do |song|
      words = [song.artist.name, song.name, song.genre.name].join(" - ")
      puts "#{count}. #{words}"
      count += 1
    end
  end

  def list_artists
    list = Artist.all.sort {|a, b| a.name <=> b.name}.uniq
    count = 1
    list.each do |art|
      puts "#{count}. #{art.name}"
      count += 1
    end
  end

  def list_genres
    list = Genre.all.sort {|a, b| a.name <=> b.name}.uniq
    count = 1
    list.each do |genre|
      puts "#{count}. #{genre.name}"
      count += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.find_by_name(input)
    list = []
    count = 1
    if artist == nil
      return
    else
      list =  artist.songs.sort {|a, b| a.name <=> b.name}.uniq
    end
    list.each do |song|
      words = [song.name, song.genre.name].join(" - ")
      puts "#{count}. #{words}"
      count += 1
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.find_by_name(input)
    list = []
    count = 1
    if genre == nil
      return
    else
      list =  genre.songs.sort {|a, b| a.name <=> b.name}.uniq
    end
    list.each do |song|
      words = [song.artist.name, song.name].join(" - ")
      puts "#{count}. #{words}"
      count += 1
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    index = gets.strip.to_i - 1
    list = Song.all.sort {|a, b| a.name <=> b.name}.uniq
    if index <= list.size
      
  end
end
