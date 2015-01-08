#encoding: utf-8

require_relative 'settings.rb'

t1    = Time.now

# Script that crawles Althingi's website,
# gathers data about general assemblies, members of parliament
# and their speeches and writes to a database.

# URI to Althingi's general assemblies.
# Contains a list of links to individual assemblies.
# Each link contains a list of links to that year's MP's.
# Each MP link directs to a list of that MP's speeches.
uri   = 'http://www.althingi.is/vefur/efn-tmra.html'
page  = Mechanize.new.get(uri)
db    = Database.new()

general_assembly_links  = page.links.select{|l| l.uri.to_s.include? GA_LINK_IDENITFIER}
general_assemblies      = general_assembly_links.map{|l| GeneralAssembly.new(page, l)}

general_assemblies[1..1].each do |ga|
  db.insert_into_general_assemblies(ga.get_ordinal, ga.get_year_from, ga.get_year_to)
  mps_links     = ga.get_links_to_mp_pages
  mps           = MembersOfParliament.new(mps_links, ga.get_mps_list_page)

  mps.each do |mp|
    mp.set_id = db.insert_into_members_of_parliament(mp.get_name)
    db.insert_into_member_of_parliament_x_general_assembly(mp.get_id, ga.get_ordinal, mp.get_party, mp.get_details)
    speech_links = mp.get_links_to_speeches

    speech_links.each do |link|
      speech_page = link.click
      if (speech_obj = speech_page.at SPEECH_DIV_IDENTIFIER)
        speech_date = link.text
        speech_content = speech_obj.text
        speech_link = speech_page.uri
        binding.pry
        db.insert_into_speeches(mp.get_id, ga.get_ordinal, mp.get_party, speech_date, speech_content, speech_link)
      end
    end
  end
end

t2 = Time.now

puts 'Halas!'
puts 'Duration: ' + (t2-t1).to_s
