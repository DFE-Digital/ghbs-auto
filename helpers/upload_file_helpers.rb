# helpers/dropzone_upload_helper.rb
module UploadFileHelpers
  # Uploads a file via a Dropzone-style hidden file input.
  def upload_file_via_dropzone(file_path, input_selector:)
    resolved_path = File.expand_path(file_path, Dir.pwd)

    raise "File not found: #{resolved_path}" unless File.exist?(resolved_path)

    dz_input = find(input_selector, visible: :all)
    dz_input.native.send_keys(resolved_path)
  end
end
