# frozen_string_literal: true

# This class is focused on Convention over configuration, ie a cleaner approach to linking our
# comps > method classes by building cached components accessors by convention.
# With this class adding new comp areas of the pack is as easy as below:
#
# require_relative "comps_registry"
# module SharedCmsComps
#  CompsRegistry.register(self, "cms")
# end
#
# For reference previously every comp had to be registered by hand in the relevant shared_X_comps.rb file with a require line and cached reader.
# If this is still here when you get to it then hopefully it's working as intended with a centralised much cleaner approach below.
module CompsRegistry
  # To start with we walk up from this file until a directory containing components/ if found, rather than assuming a fixed depth etc.
  COMPS_ROOT_PATH = begin
                      dir = __dir__
                      dir = File.dirname(dir) until File.directory?(File.join(dir, "components")) || File.dirname(dir) == dir
                      File.join(dir, "components")
                    end

  # Requires every *_comps.rb under components/<subdir>/ and defines a cached reader on +mod+ named after each file.
  def self.register(mod, subdir)
    comps_files(subdir).each do |path|
      require path

      name = File.basename(path, ".rb")
      const = resolve_const(name, path)
      mod.define_method(name) do
        (@comps_cache ||= {})[name] ||= const.new
      end
    end
  end

  def self.comps_files(subdir)
    root = File.join(COMPS_ROOT_PATH, subdir)

    # The below keeps the absolute root out of the glob pattern so the chars that are glob-significant ie ([ ] { } * ?) etc in the checkout path cant break the match.
    files = Dir.glob("**/*_comps.rb", base: root).sort.map { |rel| File.join(root, rel) }
    if files.empty?
      raise ArgumentError,
            "No *_comps.rb files found in:  #{root}\n" \
              " directory exists: #{File.directory?(root)}\n" \
              " components root : #{COMPS_ROOT_PATH} (exists: #{File.directory?(COMPS_ROOT_PATH)})\n" \
              " resolve from    : #{__dir__}"
    end

    files
  end
  private_class_method :comps_files

  # A few files are breaking convention slightly and will cause the above matcher some pain,
  # this is mostly because I'm stubborn and don't want to change them and because the naming is correct in context. e.g. Mprn is MPRN but its an acronym.
  # Below is a handful of comps that fall under the above. Here we can list them explicitly rather than it taking a failed guess at them by searching
  # Object.constants for a near match and returning something unrelated!
  INFLECTIONS = {
    "cms_mycases_page_comps" => "CmsMyCasesPageComps",
    "dfe_signin_3_invite_user_comps" => "DfeSignin3inviteUserComps",
    "energy_gas_mprn_summary_comps" => "EnergyGasMPRNSummaryComps",
  }.freeze

  # Finally we map the comp file name to the class it defines
  def self.resolve_const(file_name, path) 
    const_name = INFLECTIONS[file_name] || file_name.split("_").map(&:capitalize).join

    unless Object.const_defined?(const_name, false)
      raise NameError,
            "#{path} does not define #{const_name}\n" \
            " Component classes are named after their file: #{file_name} -> #{const_name}\n" \
            " If the class cannot be renamed, add it to the CompsRegistry::INFLECTIONS section."
    end

    Object.const_get(const_name)
  end
  private_class_method :resolve_const
end

