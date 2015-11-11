class TrackForm < BaseForm
  resource Track

  delegate_attributes %i[
    sounds
  ]

  def authors= authors
    authors.each do |author|
      record.authors << Author.find_or_initialize_by(name: author[:name])
    end
  end
end
