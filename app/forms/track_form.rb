class TrackForm < BaseForm
  resource Track

  delegate_attributes %i[
    sounds
  ]

  def authors= authors
    authors.each do |author|
      record.authors.new author
    end
  end
end
