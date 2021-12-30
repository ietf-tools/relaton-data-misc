# frozen_string_literal: true

require 'relaton_ietf'

Dir.mkdir 'data' unless Dir.exist? 'data'

Dir['./bibxml-data-misc/data/reference.*.xml'].each do |file|
  xml = File.read file, encoding: 'UTF-8'
  bib = RelatonIetf::BibXMLParser.parse xml
  filename = File.join 'data', "#{File.basename(file, '.xml')}.yaml"
  File.write filename, bib.to_hash.to_yaml, encoding: 'UTF-8'
end
