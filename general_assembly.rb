require_relative 'settings.rb'

class GeneralAssembly

	def initialize(page, link)
		@link 			= link
		@ordinal 		= link.text.gsub('.', '').to_i
		ga_year 		= link.text
		a_el 				= page.at(%Q(a:contains('#{ga_year}')))
		@details 		= a_el.parent.text
	end

	def get_ordinal
		@ordinal
	end

	def get_year_from
		@details.split('-')[0].split(' ').last.strip.gsub('.','').to_i
	end

	def get_year_to
		year_to = @details.split('-')[1]
		year_to.nil? ? nil : year_to.strip.gsub('.', '').to_i
	end

	def get_mps_list_page
		@link.click
	end

	def get_links_to_mp_pages
		get_mps_list_page.links.select{|l| l.uri.to_s.include? MP_LINKS_IDENTIFIER}
	end

end