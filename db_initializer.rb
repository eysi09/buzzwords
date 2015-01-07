require_relative 'settings.rb'
# Script to initialize database tables

dbname = 'buzzwords_development'

conn = PG.connect(
  dbname:     'buzzwords_development',
  user:       POSTGRES_USER,
  password:   POSTGRES_PASSWORD)

# Create speeches table
conn.exec("CREATE TABLE speeches (
  id                      serial PRIMARY KEY,
  date                    timestamp NOT NULL,
  member_of_parliament_id int NOT NULL,
  general_assembly_id     int NOT NULL,
  party                   varchar(255),
  content                 text,
  url                     varchar(255));")

# Create members_of_parliament table
conn.exec("CREATE TABLE members_of_parliament (
  id    serial PRIMARY KEY,
  name  varchar(255) NOT NULL UNIQUE);")

# Create general_assemblies table
conn.exec("CREATE TABLE general_assemblies (
  ordinal   int PRIMARY KEY,
  year_from varchar(4) NOT NULL,
  year_to   varchar(4));")

# Create member_of_parliament_x_general_assembly table
conn.exec("CREATE TABLE member_of_parliament_x_general_assembly (
  member_of_parliament_id int NOT NULL,
  general_assembly_id     int NOT NULL,
  party                   varchar(255),
  details                 varchar(255));")

# Create indexes