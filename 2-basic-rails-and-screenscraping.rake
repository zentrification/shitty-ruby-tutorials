# this assumes you did a
# rails new myscrapingproject && cd myscrapingproject
# rails g model ItemType name:string
# rails g model PrimaryStats dexterity:integer intelligence:integer strength:integer vitality:integer item_type:belongs_to

require 'HTTParty'
require 'Nokogiri'

# namespace inside scraper, eg rake -T scraper
namespace :scraper do

  # make our task require the rails environment
  task :scrape => :environment do
    # remove existing scraped data so we can rerun rake scraper:scrape
    delete_existing_items

    # grab page to scrape
    response = HTTParty.get('http://www.d3rmt.com/guides/diablo-3-item-stat-maximum-values/')
    doc = Nokogiri::HTML(response.body)

    item_names = find_item_names(doc)
    # debug
    puts item_names
    puts item_names.inspect

    create_item_types(item_names)
    # debug
    puts ItemType.all
  end

end

# returns an array of strings ['item one name', ...]
def find_item_names(doc)
end

def create_item_types(item_names)
  item_names.each do |name|
    ItemType.create(:name => name)
  end
end
