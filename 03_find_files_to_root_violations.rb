#! /usr/bin/env ruby

require 'packs'
require 'parse_packwerk'
require 'constant_resolver'

autoload_paths = Packs.all.flat_map do |pack|
    base_pack_absolute_path = pack.relative_path
    base_pack_absolute_path.glob("app/*") +
    base_pack_absolute_path.glob("app/*/concerns")
  end.map &:to_s

r = ConstantResolver.new(
    root_path: Pathname.pwd.to_s, 
    load_paths: autoload_paths,  
)

result = ParsePackwerk.find('.').violations.map(&:class_name).map do |clazz|
    r.resolve(clazz)
end.map &:location

puts result.join(" ")