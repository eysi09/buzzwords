require_relative 'settings.rb'

class DbUtils

	def initalize
		@conn = PG.connect(
      dbname:     'buzzwords_development',
      user:       POSTGRES_USER,
      password:   POSTGRES_PASSWORD)
	end

	def insert_into_general_assembly(ordinal, year_from, year_to)
		res = @conn.exec("INSERT INTO general_assemblies (ordinal, year_from, year_to)
			VALUES (#{ordinal}, #{year_from}, #{year_to});")
	end

	def insert_into_members_of_parliament(name)
	end

	def insert_into_members_of_parliament_x_general_assembly(mp_id, ga_id, party, details)
		@conn.exec("INSERT INTO general_assemblies (member_of_parliament_id, general_assembly_id, party, details)
			VALUES (#{mp_id}, #{ga_id}, #{party}, #{details});")
	end

	def insert_into_speeches(mp_id, ga_id, party, date, content, link)
	end

end