require_relative 'settings.rb'

# URI to MP's speeches for Althingi's 144th year.
# Contains a list of links representing MP's. 
# Each link directs to a list of that MP's speeches.
uri = 'http://www.althingi.is/vefur/efn-tmra.html?thing=144'

# Initialize MembersOfParliaments list of MPs.
# mps_links can be shortened for quicker runtime, e.g. mps_links[0..2]
mps_list_page = Mechanize.new.get(uri)
mps_links     = mps_links = mps_list_page.links.select{|l| l.uri.to_s.include? MP_LINKS_IDENTIFIER}
mps           = MembersOfParliament.new(mps_links, mps_list_page)

# Example usage:

ossur = mps.get_mp_by_name('Össur Skarphéðinsson')
puts ossur.get_details
puts ossur.get_word_freq
