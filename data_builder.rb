require_relative 'settings.rb'

class DataBuilder

  def initialize
    @conn = PG.connect(
      dbname:   'buzzwords_development',
      user:     'postgres',
      password: 'number9')
  end

  def create_table(table_name)
    @conn.exec("CREATE TABLE #{table_name} (
      id SERIAL PRIMARY KEY,
      name varchar(255) NOT NULL);")
  end

  def drop_table(table_name)
    @conn.exec("DROP TABLE #{table_name};")
  end

  def insert(table_name, columns, values)
    @conn.exec("INSERT INTO #{table_name} (#{columns}) VALUES (#{values});")
  end

end