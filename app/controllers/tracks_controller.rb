class TracksController < ApplicationController
  include Dry::Controller

  dry_attrs_write :name, :file
  dry_attrs_options file: :file_field
end
