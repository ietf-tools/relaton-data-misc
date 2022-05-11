# frozen_string_literal: true

require 'relaton_ieee'

Dir.mkdir 'data' unless Dir.exist? 'data'

Dir['./bibxml-data-misc/data/reference.*.xml'].each do |file|
  xml = File.read file, encoding: 'UTF-8'
  doc = Nokogiri::XML xml
  ref = doc.at '/reference'
  type = ref[:anchor].split('.').first
  bib = case type
        when 'IEEE' then RelatonIeee::BibXMLParser.parse xml
        else RelatonBib::BibXMLParser.parse xml
        end
  filename = File.join 'data', "#{File.basename(file, '.xml')}.yaml"
  File.write filename, bib.to_hash.to_yaml, encoding: 'UTF-8'
end
