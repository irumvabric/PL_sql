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
