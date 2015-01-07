require 'mechanize'
require 'pry'
require 'awesome_print'
require 'pg'
require_relative 'member_of_parliament.rb'
require_relative 'members_of_parliament.rb'
require_relative 'data_builder.rb'
require_relative 'db_settings.rb'

SPEECH_LINK_IDENTIFIER  	= '/altext/raeda/144'
SPEECH_LINK_IDENTIFIER_OLD 	= '/altext/gomulraeda.php4'
SPEECH_DIV_IDENTIFIER   	= 'div#raeda_efni'
SPEECH_DIV_IDENTIFIER_OLD	= ''
MP_LINKS_IDENTIFIER     	= 'dba-bin/raedur.pl?radsv=0&lthing=144'
