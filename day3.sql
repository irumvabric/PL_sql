create or replace package P_client
is
procedure update_client_tel(client_id CLIENT.CLIENTID%type,tel_cl CLIENT.TELEPHONE_CL%type);

procedure update_client_addr(client_id CLIENT.CLIENTID%type, addr_client CLIENT.ADRESSE_CL%type);

procedure update_client_email(client_id CLIENT.CLIENTID%type,email_cl CLIENT.EMAIL_CL%type);

function info_client(client_id CLIENT.CLIENTID%type) RETURN CLIENT%rowtype;

procedure supprimer_client(client_id CLIENT.CLIENTID%type);

end P_client;
/


create or replace package body P_client
is
procedure update_client_tel(client_id CLIENT.CLIENTID%type,tel_cl CLIENT.TELEPHONE_CL%type)
is
begin
Update CLIENT set TELEPHONE_CL = tel_cl WHERE CLIENTID = client_id;
end;

procedure update_client_addr(client_id CLIENT.CLIENTID%type, addr_client CLIENT.ADRESSE_CL%type)
is
begin
Update CLIENT set ADRESSE_CL = addr_client WHERE CLIENTID = client_id;
end;

procedure update_client_email(client_id CLIENT.CLIENTID%type,email_cl CLIENT.EMAIL_CL%type)
is
begin
Update CLIENT set EMAIL_CL = email_cl WHERE CLIENTID = client_id;
end;

function info_client(client_id CLIENT.CLIENTID%type) RETURN  CLIENT%rowtype
is
l_client CLIENT%rowtype;
begin
select * into l_client from CLIENT where CLIENTID=client_id;
return l_client;
end;

procedure supprimer_client(client_id CLIENT.CLIENTID%type)
is
begin
Delete FROM CLIENT WHERE CLIENTID = client_id;
end;

end P_client;
/






BEGIN
    -- Calling the procedure
    P_client.supprimer_client(11);
    P_client.update_client_tel(10,'76765764');
    P_client.update_client_addr(9,'Musaga');
    P_client.update_client_email(8,'trette@gmail.com');
    
--    -- Calling the function and storing the result in a variable
--    DECLARE
--        v_result VARCHAR2(100);
--    BEGIN
--        v_result := my_package.my_function('Test Function');
--        DBMS_OUTPUT.PUT_LINE(v_result);
--    END;
END;
/


--------------------------Triggers---------------------------------------

CREATE or REPLACE TRIGGER low_upper
    BEFORE
    INSERT ON client
    FOR EACH ROW
BEGIN
    :new.NOMCLIENT := upper(:new.NOMCLIENT);
END;
/



----------------------AutoIncrement------------------------------------


create or replace trigger cleauto_client
before insert on client
for each row
declare
n integer;
newkey integer;
preums exception;
begin
--Recherche s'il existe des tuples dans la table
select count(*) into n from client;
if n=0 then
raise preums;-- Premiere insertion
end if;
-- Recherche la valeur de la clé C la plus élevée
-- et affecte C+1 à la nouvelle clé
select max(CLIENTID) into newkey from client;
:new.CLIENTID := newkey+1;
exception
-- Premier numero=1
when preums then :new.CLIENTID := 1;
end;
/




