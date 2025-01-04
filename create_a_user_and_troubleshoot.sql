------------------Go to the console----------------------------
 Command : sqlplus

------------------Login like a admin_SuperUser--------------------------

/as sysdba

------------------TroubleShoot-----------------------------
alter session set "_ORACLE_SCRIPT"=true;

------------------Create a user--------------------------
CREATE USER nziga IDENTIFIED BY bujumbura;

------------------Grant permission to a user--------------------------
grant sysdba to nziga;
grant connect to nziga;
grant create session to nziga;
grant OEM_MONITOR to nziga;
GRANT SELECT ANY DICTIONARY to nziga;
GRANT SELECT_CATALOG_ROLE to nziga;
grant create table to nziga;
grant create procedure to nziga;
grant create sequence to nziga;
grant create trigger to nziga;
grant create type to nziga;
grant unlimited tablespace to nziga
