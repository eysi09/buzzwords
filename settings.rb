require 'mechanize'
require 'pry'
require 'awesome_print'
require_relative 'member_of_parliament.rb'
require_relative 'members_of_parliament.rb'

SPEECH_LINK_IDENTIFIER  = '/altext/raeda/144'
SPEECH_DIV_IDENTIFIER   = 'div#raeda_efni'
MP_LINKS_IDENTIFIER     = 'dba-bin/raedur.pl?radsv=0&lthing=144'