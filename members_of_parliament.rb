require 'forwardable'
require_relative 'settings.rb'

# A list of MemberofParliament objects
class MembersOfParliament

  include Enumerable
  extend Forwardable
  def_delegators :@mps, :each, :<<, :[], :last, :find, :count

  # 'links' is an array of Mechanize::Page::Link objects.
  # Each object represents a member of parliaments' page
  # that contains his/hers speeches for a given parliament year.
  # 'page' is Mechanize::Page objects that represents the page on
  # Althingi's website that contains a list of MP's for
  # a given parliament year.
  def initialize(links, page)
    @mps = []
    links.each do |link|
      mp_name     = link.text
      mp_details  = page.at('li:contains(mp_name)').children[1].text
      mp_uri      = page.uri.merge link.uri # Get absolute URI
      mp          = MemberOfParliament.new(mp_name, mp_details, mp_uri)
      @mps << mp
    end
  end

  def get_mp_by_name(name)
    @mps.find{|mp| mp.get_name == name}
  end

  def get_all_words_freqs
  end

  def write_all_to_csv
  end

end