Create or Replace Function F_client(idClient in number)
Return varchar2
IS
    nom varchar2(20);
BEGIN 
    SELECT NOM_CL INTO nom FROM CLIENT WHERE CLIENTID = idClient;
    Return nom;

END;
/


----------------------------------------------------------------------------

SET SERVEROUTPUT

DECLARE
  idCLient := &idCLient;
  nom varchar2(20);
BEGIN
  nom := F_client(idCLient);
  SYS.DBMS_OUTPUT_LINE('NOM : '||' '||nom);
EXCEPTION
  -- Handle errors here (optional)
  WHEN OTHERS THEN
    -- Handle any exceptions that occur
END;
/


----------------------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE
  idCLient number:=&idCLient;
  nom varchar2(20);
BEGIN
  nom := F_client(idCLient);
  SYS.DBMS_OUTPUT.PUT_LINE('NOM : '||' '||nom);
END;
/

----------------------------------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE
  idCLient := &idCLient;
  nom varchar2(20);
BEGIN
  nom := F_client(idCLient);
  DBMS_OUTPUT.PUT_LINE('NOM : %s', nom);
EXCEPTION
  -- Handle errors here (optional)
  WHEN OTHERS THEN
    -- Handle any exceptions that occur
END;
/

----------------------------------------------------------------------------


INSERT INTO ARTICLE (ARTICLEID, NOM_ART, DESCRIPTION_ART, PRIX_ART, FOURNISSEURID, CLIENTID, VENDEURID)
VALUES (1,'Champoing','Produit cosmetique',2000,1,3,2);


INSERT INTO CLIENT (CLIENTID, NOM_CL, ADRESSE_CL, TELEPHONE_CL, EMAIL_CL)
VALUES (2,'Keza','Kigobe','257767654','keza@gmail.com');

INSERT INTO CLIENT (CLIENTID, NOM_CL, ADRESSE_CL, TELEPHONE_CL, EMAIL_CL)
VALUES (3,'Jimmy','Kiriri','257767654','jimmy@gmail.com');

INSERT INTO CLIENT (CLIENTID, NOM_CL, ADRESSE_CL, TELEPHONE_CL, EMAIL_CL)
VALUES (4,'Terry','Jabe','257767654','terry@gmail.com');

INSERT INTO CLIENT (CLIENTID, NOM_CL, ADRESSE_CL, TELEPHONE_CL, EMAIL_CL)
VALUES (5,'Franck','Bwiza','257767654','franck@gmail.com');

INSERT INTO CLIENT (CLIENTID, NOM_CL, ADRESSE_CL, TELEPHONE_CL, EMAIL_CL)
VALUES (6,'Jeanne','Kanyosha','257767654','jeanne@gmail.com');


---------------------------------------------------------------------------


CREATE OR REPLACE Function ChangementDeNomClient
(
id_Cl in CLIENT.CLIENTID%Type,
nom_Cl in VARCHAR2
)
Return varchar2
IS 
nom varchar2(20);
BEGIN
--Changement de Nom du Client
    UPDATE CLIENT SET NOM_CL = nom_Cl WHERE CLIENTID = id_Cl;
    SELECT NOM_CL INTO nom FROM CLIENT WHERE CLIENTID = id_Cl;
    Return nom;
END;
/

--------------------------------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE
  idCLient number:=3;
  nomNouveau varchar2(20) := 'Arakaza';
  nom varchar2(20);
BEGIN
  nom := ChangementDeNomClient(idCLient,nomNouveau);
  SYS.DBMS_OUTPUT.PUT_LINE('NOM : '||' '||nom);
END;


