create or replace package P_article
is
procedure add_article(id article.IDART%type, num_cli article.NUMCLIENT%type,
id_four article.IDFOUR%type,id_vend article.IDVEND%type,nom_art article.NOMART%type,
prix_unit article.PRIXUNTART%type);
--surcharge deux procedure de meme nom mais de meme parametres et nombre differents 
procedure add_article(id article.idart%type, num_cli article.NUMCLIENT%type,CCLI
id_four article.IDFOUR%type,id_vend article.IDVEND%type,prix_unit article.PRIXUNTART%type);

procedure info_article(id article.IDART%type);

function affiche_prix(id article.IDART%type)return number;

procedure supprimer_article(id article.IDART%type);

procedure supprimer_article;--procedure sans parametres
end P_article;
/

create or replace package body P_article
is
procedure add_article
(id article.idart%type, num_cli article.NUMCLIENT%type,
id_four article.IDFOUR%type,id_vend article.IDVEND%type,
nom_art article.NOMART%type,prix_unit article.PRIXUNTART%type)
is
begin
insert into article(IDART,NUMCLIENT,IDFOUR,IDVEND,NOMART,PRIXUNTART)
values(id,num_cli,id_four,id_vend,nom_art,prix_unit);
end;

procedure add_article(id article.idart%type, num_cli article.NUMCLIENT%type,
id_four article.IDFOUR%type,id_vend article.IDVEND%type,prix_unit article.PRIXUNTART%type)
is
begin
insert into article(IDART,NUMCLIENT,IDFOUR,IDVEND,PRIXUNTART)
values(id,num_cli,id_four,id_vend,prix_unit);
end;

procedure info_article(id article.IDART%type)
is
var_numCli article.NUMCLIENT%type;
var_idFour article.IDFOUR%type;
var_idvend article.IDVEND%type;
var_nomart article.NOMART%type;
var_prixUnit article.PRIXUNTART%type;
begin
select NUMCLIENT,IDFOUR,IDVEND,NOMART,PRIXUNTART into 
var_numCli,var_idFour,var_idvend,var_nomart,var_prixUnit 
from article where IDART=id; 
DBMS_OUTPUT.PUT_LINE(var_numCli);
DBMS_OUTPUT.PUT_LINE(var_idFour);
DBMS_OUTPUT.PUT_LINE(var_idvend);
DBMS_OUTPUT.PUT_LINE(var_nomart);
DBMS_OUTPUT.PUT_LINE(var_prixUnit);
end;

function affiche_prix(id article.IDART%type)return number
is
var_prixUnit article.PRIXUNTART%type;
begin
select PRIXUNTART into var_prixUnit from article where IDART=id;
return var_prixUnit;
end;

procedure supprimer_article(id article.IDART%type)
is
begin
delete from article where IDART=id;
commit;
end;


procedure supprimer_article
is
cursor c_art is select IDART from article;
var_id article.IDART%type;
begin
open c_art;
loop
fetch c_art into var_id;
exit when c_art%notfound;
if affiche_prix(var_id)in (500,100,600)then
delete from article where IDART=var_id;
commit;
end if;
end loop;
end;
end P_article;
/
