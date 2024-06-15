/*******************************************************************************
   Chinook Database - Version 1.4.5
   Script: Chinook_Oracle.sql
   Description: Creates and populates the Chinook database.
   DB Server: Oracle
   Author: Luis Rocha
   License: https://github.com/lerocha/chinook-database/blob/master/LICENSE.md
********************************************************************************/

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP USER chinook CASCADE;

/*******************************************************************************
   Create database
********************************************************************************/
CREATE USER chinook IDENTIFIED BY chinook QUOTA UNLIMITED ON USERS;

GRANT connect to chinook;
GRANT resource to chinook;
GRANT create session TO chinook;
GRANT create table TO chinook;
GRANT create view TO chinook;

commit;
