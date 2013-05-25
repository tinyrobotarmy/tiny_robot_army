# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version(:thumb) { process resize_to_fit: [150, 150] }

  def default_url
    if version_name.present?
      "blank_#{version_name}.png"
    else
      "blank.png"
    end
  end

  def store_dir
    "#{model.class.table_name}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if creating_versions?
      original_filename
    elsif new_upload?
      "#{mounted_as}-#{uploaded_timestamp}.#{file.extension}"
    end
  end

  private

  # this method is totally surprising, but it's the recommended way to generate a
  # unique, cache busting file name for each upload. See the wiki at
  # https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Create-random-and-unique-filenames-for-all-versioned-files
  def uploaded_timestamp
    var = :"@#{mounted_as}_uploaded_timestamp"
    model.instance_variable_get(var) || model.instance_variable_set(var, Time.zone.now.to_i)
  end

  def creating_versions?
    original_filename && original_filename == model.read_attribute(:file_name)
  end

  def new_upload?
    original_filename.present?
  end
end
