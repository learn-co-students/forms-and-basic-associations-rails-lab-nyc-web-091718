class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    # ternary operator used: if self.artist is true, then self.artist.name, else nil.
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    # ternary operator used: if self.genre is true, then self.genre.name, else nil.
    self.genre ? self.genre.name : nil
  end

  def note_contents=(contents)
    no_empty_contents = contents.reject{|c| c.blank?}
    if no_empty_contents.size != 0
      no_empty_contents.each do |content|
        note = Note.find_or_create_by(content: content)
        self.notes << note
      end #end each method
    else
      "no content available"
    end #end if stmt
  end #end note_contents= method

  def note_contents
    # ternary operator used: if self.note is true, then self.note.name, else nil.
    self.notes ? self.notes.map {|n| n.content} : nil
  end

end
