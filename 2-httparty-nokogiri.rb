require 'HTTParty'
require 'Nokogiri'

response = HTTParty.get('http://www.d3rmt.com/guides/diablo-3-item-stat-maximum-values/')
#f.puts response.body, response.code, response.message, response.headers.inspect

doc = Nokogiri::HTML(response.body)

# ruby has an interesting class heirachary, everything's an object
# http://rubylearning.com/images/class.gif

# ruby also has very powerful enumerators
# they tend to be used in place of traditional c style for/while loops
# (although those are available as well)
# http://ruby-doc.org/core-1.9.3/Enumerable.html
# look at:
#   collect, each_with_index, inject, map, partition, sort
# reading:
#   http://blog.jayfields.com/2008/03/ruby-inject.html
#   http://blog.flvorful.com/articles/2010/01/24/a-simple-pattern-for-rubys-inject-method


# array to store results
tables = []

doc.search('table').each do |table|
  # << is shorthand for array.push()
  tables << table.search('tr').collect do |tr|
    tr.search('td').collect do |td|
      td.text
    end
  end

  # the above can also be written in the shorter form
  # note:
  #   {} has higher precedence than do |var| ... end
  ############################################################
  # tables << table.search('tr').collect { |tr| tr.search('td').collect { |td| td.text } }
end

# open file to write response
f = File.open('d3val.html','w')
#f.puts response.body

# {} is the same as Hash.new
weapons_attributes = {}

tables.each do |table|

  # first row of each table is the attribute headings we're trying to track
  heading = table.shift
  label = heading.shift

  table.each do |row|
    item_name = row.shift

    if weapons_attributes.has_key? item_name
      # http://www.ruby-doc.org/core-1.9.3/Hash.html#method-i-merge-21
      weapons_attributes[item_name].merge! Hash[heading.zip row]
    else
      weapons_attributes[item_name] = Hash[heading.zip row]
    end

  end
end

puts weapons_attributes.keys
puts weapons_attributes['Shield']
