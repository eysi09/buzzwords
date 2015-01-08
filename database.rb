require_relative 'settings.rb'

class Database

	def initialize
		@conn = PG.connect(
      dbname:     'buzzwords_development',
      user:       POSTGRES_USER,
      password:   POSTGRES_PASSWORD)
	end

	def insert_into_general_assemblies(ordinal, year_from, year_to)
		@conn.exec(%Q(INSERT INTO general_assemblies (ordinal, year_from, year_to)
			VALUES (#{ordinal}, #{year_from}, #{year_to});))
	end

	def insert_into_members_of_parliament(name)
    if (res = @conn.exec(%Q(SELECT id FROM members_of_parliament
      WHERE name = '#{name}')).count > 0
      res[0]['id'].to_i
    else
      @conn.exec(%Q(INSERT INTO members_of_parliament (name)
        VALUES ('#{name}') returning id;))[0]['id'].to_i
    end
	end

	def insert_into_member_of_parliament_x_general_assembly(mp_id, ga_id, party, details)
		@conn.exec(%Q(INSERT INTO member_of_parliament_x_general_assembly (member_of_parliament_id, general_assembly_id, party, details)
			VALUES (#{mp_id}, #{ga_id}, '#{party}', '#{details}');))
	end

	def insert_into_speeches(mp_id, ga_id, party, date, content, link)
    @conn.exec(%Q(INSERT INTO speeches (member_of_parliament_id, general_assembly_id, party, date, content, link)
      VALUES (#{mp_id}, #{ga_id}, '#{party}', #{date}, '#{content}', '#{link}');))
	end

  def empty_table(table_name)
    @conn.exec("TRUNCATE #{table_name}")
  end

end