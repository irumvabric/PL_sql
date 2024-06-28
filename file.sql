SET SERVEROUTPUT ON

DECLARE
    id_Foruniseur FOURNISSEUR.FournisseurID%Type;
    Nom_fourniseeur FOURNISSEUR.NOM_FOURN%Type;
    adder_Foruniseur FOURNISSEUR.Adresse_Fourn%Type;
    tele_fourniseeur FOURNISSEUR.Telephone_Fourn%Type;
    email_Foruniseur FOURNISSEUR.Email_Fourn%Type;
    Cursor C Is SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn FROM FOURNISSEUR WHERE FOURNISSEURID= 1;

BEGIN
    SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn INTO id_Foruniseur,Nom_fourniseeur,adder_Foruniseur,tele_fourniseeur,email_Foruniseur FROM FOURNISSEUR WHERE FOURNISSEURID= 1;
    
    OPEN C;
        FETCH C INTO id_Foruniseur,Nom_fourniseeur,adder_Foruniseur,tele_fourniseeur,email_Foruniseur;
        SYS.DBMS_OUTPUT.PUT_LINE(id_Foruniseur||' '||Nom_fourniseeur||' '||adder_Foruniseur||' '||tele_fourniseeur||' '||email_Foruniseur);
    CLOSE C;

END;
/

SELECT * FROM FOURNISSEUR;

SET SERVEROUTPUT ON

DECLARE
    id_F FOURNISSEUR.FournisseurID%Type;
    Nom_F FOURNISSEUR.NOM_FOURN%Type;
    adder_F FOURNISSEUR.Adresse_Fourn%Type;
    tele_F FOURNISSEUR.Telephone_Fourn%Type;
    email_F FOURNISSEUR.Email_Fourn%Type;
    Cursor C(id_fournisseur in FOURNISSEUR.FournisseurID%Type,nom_fournisseur in FOURNISSEUR.NOM_FOURN%Type,addresse in FOURNISSEUR.Adresse_Fourn%Type) Is SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn FROM FOURNISSEUR WHERE FOURNISSEURID= id_fournisseur AND Nom_Fourn = nom_fournisseur AND Adresse_Fourn = addresse ;

BEGIN
--    SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn INTO id_Foruniseur,Nom_fourniseeur,adder_Foruniseur,tele_fourniseeur,email_Foruniseur FROM FOURNISSEUR WHERE FOURNISSEURID= 1;
    
    OPEN C(1,'Arakaza','Kigobe');
        FETCH C INTO id_F,Nom_F,adder_F,tele_F,email_F;
        SYS.DBMS_OUTPUT.PUT_LINE(id_F||' '||Nom_F||' '||adder_F||' '||tele_F||' '||email_F);
    CLOSE C;

END;
/






SET SERVEROUTPUT ON

DECLARE
        var1 VARCHAR2(30) := 'Bujumbura';
   
BEGIN    
    
    DECLARE
        var1 VARCHAR2(30) := 'BURUNDI';

    BEGIN
        SYS.DBMS_OUTPUT.PUT_LINE(var1);
    

    END;
        SYS.DBMS_OUTPUT.PUT_LINE(var1);

END;
/



SET SERVEROUTPUT ON

DECLARE
    temp ARTICLE%rowtype;
BEGIN
    SELECT * into temp FROM ARTICLE WHERE ARTICLEID = 1;
    EXCEPTION 
        WHEN no_data_found THEN
        DBMS_OUTPUT.put_line('No data');
END;
/


SET SERVEROUTPUT ON

DECLARE
    okexc EXCEPTION;
    i ARTICLE%ROWTYPE;

BEGIN
    FOR i IN (SELECT * FROM ARTICLE) LOOP
        IF i.ARTICLEID IS NOT NULL THEN
            RAISE okexc;
        END IF;
    END LOOP;

EXCEPTION 
    WHEN okexc THEN
        DBMS_OUTPUT.put_line('Num exist');
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('An unexpected error occurred: ' || SQLERRM);
END;
/




SET SERVEROUTPUT ON

DECLARE
    id_Foruniseur FOURNISSEUR.FournisseurID%Type;
    Nom_fourniseeur FOURNISSEUR.NOM_FOURN%Type;
    adder_Foruniseur FOURNISSEUR.Adresse_Fourn%Type;
    tele_fourniseeur FOURNISSEUR.Telephone_Fourn%Type;
    email_Foruniseur FOURNISSEUR.Email_Fourn%Type;
    Cursor C Is SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn FROM FOURNISSEUR WHERE FOURNISSEURID= 1;

BEGIN
    SELECT FournisseurID, Nom_Fourn, Adresse_Fourn, Telephone_Fourn, Email_Fourn INTO id_Foruniseur,Nom_fourniseeur,adder_Foruniseur,tele_fourniseeur,email_Foruniseur FROM FOURNISSEUR WHERE FOURNISSEURID= 1;
    
    OPEN C;
        FETCH C INTO id_Foruniseur,Nom_fourniseeur,adder_Foruniseur,tele_fourniseeur,email_Foruniseur;
        SYS.DBMS_OUTPUT.PUT_LINE(id_Foruniseur||' '||Nom_fourniseeur||' '||adder_Foruniseur||' '||tele_fourniseeur||' '||email_Foruniseur);
    CLOSE C;

END;
/




SET SERVEROUTPUT ON
DECLARE
Nom VARCHAR2(20):='MUHETO JEANNE ';
nomdate VARCHAR2(30):='MA date de naissance est ';
numdate NUMBER:='2003';
BEGIN
DBMS_OUTPUT.PUT_LINE('MON NOM EST ' || Nom || nomdate || numdate);
END;
/

SET SERVEROUTPUT ON
DECLARE
nomuni VARCHAR2(10) := 'BU';
BEGIN
IF nomuni = 'BIU' THEN
DBMS_OUTPUT.PUT_LINE('LA CONDITION EST VERIFIE');
ELSE 
DBMS_OUTPUT.PUT_LINE('LA CONDITION NON VERIFIE');
END IF;
END;
/

SET SERVEROUTPUT ON
DECLARE 
number1 NUMBER:= 8;
number2 NUMBER:= 6;
somme NUMBER;
produit NUMBER;
BEGIN
IF (number1>number2)THEN
somme:= number1+number2;
DBMS_OUTPUT.PUT_LINE(somme);
ELSIF(number1<number2)THEN
produit:= number1*number2;
DBMS_OUTPUT.PUT_LINE(produit);
END IF;
END;
/

SET SERVEROUTPUT ON
DECLARE
resultat NUMBER:=60;
BEGIN
IF(resultat<50)THEN
DBMS_OUTPUT.PUT_LINE('VOUS AVEZ ECHOUE ');
ELSE
    IF(resultat>50)THEN
DBMS_OUTPUT.PUT_LINE('VOUS AVEZ REUSSI ');
ELSE
    IF(resultat>70)THEN
DBMS_OUTPUT.PUT_LINE('EXELENT ');
END IF;
END IF;
END IF;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN
LOOP 
DBMS_OUTPUT.PUT_LINE('number1= '||number1);
number1:=number1+1;
IF(number1>10)THEN
EXIT;
END IF;
END LOOP;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN
while number1<10 LOOP
DBMS_OUTPUT.PUT_LINE('number1= '||number1);
number1:=number1+1;
END LOOP;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN 
FOR number1 in 1 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE('number1= '||number1);
END LOOP;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN 
FOR number1 in 1 .. 10 LOOP
EXIT WHEN number1>4;
    DBMS_OUTPUT.PUT_LINE('number1= '||number1);
END LOOP;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN 
FOR number1 in 1 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE('number1= '||number1);
    IF(number1>4)THEN
    CONTINUE;
    END IF;
END LOOP;
END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=0;
BEGIN 
FOR number1 in 1 .. 10 LOOP
    IF(number1=4)THEN
    GOTO derniereinstruction;
    END IF;
    DBMS_OUTPUT.PUT_LINE('number1= '||number1);
    END LOOP;
    <<derniereinstruction>>
    DBMS_OUTPUT.PUT_LINE('SORTIE A LA BOUCLE= '||number1);
    END;
/

SET SERVEROUTPUT ON
DECLARE
number1 number:=5;
number2 number:=7;
compteur number;
i number:=&compteur;
somme number;
BEGIN 
    CASE i
          WHEN 1 THEN
          somme:=number1+number2;
              DBMS_OUTPUT.PUT_LINE('SOMME= '||somme);    
          ELSE
              DBMS_OUTPUT.PUT_LINE('No matching case');
    END CASE;      
    END;
/
