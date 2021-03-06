class MusicLibraryController

  def initialize(path = './db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
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
    input = gets
    if input == "list songs"
      list_songs
    elsif input == "list artists"
      list_artists
    elsif input == "list genres"
      list_genres
    elsif input == "list artist"
      list_songs_by_artist
    elsif input == "list genre"
      list_songs_by_genre
    elsif input == "play song"
      play_song
    elsif input != "exit"
      call
    end
  end

  def list_songs
    Song.all.sort{|a, b| a.name <=> b.name}.each_with_index.collect do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name}.uniq.each_with_index.collect do |artist, index|
        puts "#{index + 1}. #{artist.name}"
      end
  end

  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.uniq.each_with_index.collect do |genre, index|
        puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    Artist.all.each do |artist|
        if artist.name == input
          artist.songs.collect{|song| "#{song.name} - #{song.genre.name}"}.sort.each_with_index.collect do |song, index|
          puts "#{index + 1}. #{song}"
          end
        end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    Genre.all.each do |genre|
      if genre.name == input
        genre.songs.sort{|a,b|a.name <=> b.name}.each_with_index.collect{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_choice = gets.to_i
    if song_choice > 0 && song_choice <= Song.all.count
      list = Song.all.sort{|a, b| a.name <=> b.name}.collect do |song, index|
        "#{song.name} by #{song.artist.name}"
       end
       puts "Playing #{list[(song_choice - 1)]}"
    end
  end

end
