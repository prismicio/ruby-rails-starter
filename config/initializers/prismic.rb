PRISMIC_PATH = File.dirname(__FILE__) + "/ruby-kit/lib"

puts "Add #{PRISMIC_PATH} in the load path"

$LOAD_PATH << PRISMIC_PATH

puts "=== Load Prismic ==="

require 'prismic'
