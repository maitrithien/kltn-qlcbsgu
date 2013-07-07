#!/usr/bin/ruby -w
#
require "dbi"

begin
     # connect to the MySQL server
     db_name = ARGV.first
     dbh = DBI.connect("DBI:Mysql:#{db_name}:127.0.0.1", 
	                    "root", "")

     puts "Database '#{db_name}' is connected!\n"
     # get server version string and display it
     row = dbh.select_one("SELECT VERSION()")
     puts "Server version: " + row[0]
     
     puts dbh.func(:client_info)
     puts dbh.func(:client_version)
     puts dbh.func(:host_info)
     puts dbh.func(:proto_info)
     puts dbh.func(:server_info)
     puts dbh.func(:thread_id)
     puts dbh.func(:stat)

     sth = dbh.prepare("INSERT INTO group_products (name, description)
                        VALUES(?,?)")
     sth.execute("aaaa", "bbbb")
     sth.execute("cccc", "dddd")
     sth.finish
     sth.commit
     
     puts "Record has been created"
rescue DBI::DatabaseError => e
     puts "An error occurred"
     puts "Error code:    #{e.err}"
     puts "Error message: #{e.errstr}"

     #dbh.rollback
ensure
     # disconnect from server
     dbh.disconnect if dbh
end