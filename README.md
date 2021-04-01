# dbis_lab2

1. Edit flyway.conf file in /conf folder of flyway directory
2. To create a new normalized database structure add file V1__create_tables.sql to /sql folder in flyway directory
3. If you already have a data in your database you want to migrate, add file V2__migrate_data.sql to the /sql folder too.
   BEWARE! Script V2__migrate_data.sql requires one big "eng_results" table to work properly (algorithm of creating "eng_results" table look at this link: https://github.com/BuslaievValerii/dbis_lab1 )
3. In command line go to your flyway directory and run "flyway migrate" command
4. To get selection result according to personal asignment check db connect configuration in "settings.ini", then run select_lab.py
