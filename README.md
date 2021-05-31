# Bash-DBMS
****************************************************************
#------->          Welcome To DataBase Engine          <-------#
#------->            Created by Assem Gamal            <-------#    
#------->		     Js-UNIX                   <-------#
****************************************************************
################
#About Js-UNiX #
################

- Js-UNiX is open source simple database management system.

- The Project aim to develop DBMS, that will enable users to
  store and retrieve the data from Hard-disk.

- Program was created in 2021 by Assem Gamal
  for ITI intake "41" Bash script course.

- Program is based on jq - Command-line tool for parsing JSON.
  JQ basically is sed command but for JSON files only.

################################################################
***WARNING!!!
Js-UNIX won't run without installing JQ command.
################################################################
The Project Features:
################################################################

**The Application is CLI Menu based app, that will provide 
to user this Menu items:

Main Menu:
- Create Database
- List Databases
- Connect To Databases
- Drop Database

**Up on user Connect to Specific Database a new Screen
with this Menu items:

Connected Menu:
- Create Table 
- List Tables
- Drop Table
- Update Table
- Insert into Table
- Select From Table
- Delete From Table

################################################################
How It Works:
################################################################

- Js-UNiX stores all databases as directory inside directory
  named storage

- All databases names must be characters and unique.

- Dropping database will move it to directory named trach
  as soft delete.

- You have empty your trash option for permanent delete.
----------------------------------------------------------------

- Creating table with characters only and must be unique.

- Table columns can have only 2 types [str,int].

- Table primary key can be int or str but MUST be unique.

- Inserting into table is done raw by raw.

- Dropping table is soft delete exactly like database.

- You can update any row by entering primary key value
  for that raw but you can't update primary key value.

- You can delete any row by entering primary key value
  for that raw but you can't undo that action.

- You can select all table, specific coulmns and specific row .

################################################################
Installation:
################################################################

- Js-UNIX is built on JQ Command-line JSON processor so program
  won't work unless you install jq command.

- No other installation is requierd. 

- Make sure all scripts in scripts directory is executable.

- Start program by running Main.sh script.
################################################################
#                Thanks For Using Js-Unix                      #
################################################################
