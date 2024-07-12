----------------------1 er question------------------------------
drop table etudiant;

create table etudiant(
idetu int Primary Key,
nometu VARCHAR2(30),
prenometu VARCHAR2(30),
ageetu number,
adressetu VARCHAR2(30))


select * from etudiant;

--------------------------------------------------------------
drop table frais;


create table frais(
idfrais int Primary Key,
idetu int,
CONSTRAINT fk_idEtu FOREIGN KEY (idetu)
REFERENCES etudiant(idetu) ON DELETE CASCADE,
libellefrais VARCHAR2(100),
montant int)

select * from frais;

---------------------------------------

delete From fraisEtudiant;


create table fraisEtudiant(
numeroetudiantnumber number,
montant_totalnumber number)

select * from fraisEtudiant;


DELETE FROM fraisEtudiant WHERE numeroetudiantnumber = 5;

----------------------2 eme question------------------------------

create or replace trigger autoincrement_etudiant
before insert on etudiant
for each row
declare
nombre number;
nouveaucle_etu number;
prenumber_etu exception;
Begin
SELECT count(*) into nombre from etudiant;
if nombre = 0 then
    raise prenumber_etu;
END IF;
select max(idetu) into nouveaucle_etu from etudiant;
    :new.idetu := nouveaucle_etu + 1;

EXCEPTION
WHEN prenumber_etu then  :new.idetu := 1;
ENd;
/

create or replace trigger autoincrement_frais
before insert on frais
for each row
declare
nombre number;
nouveaucle_frais number;
prenumber_frais exception;
Begin
SELECT count(*) into nombre from frais;
if nombre = 0 then
    raise prenumber_frais;
END IF;
select max(idfrais) into nouveaucle_frais from frais;
    :new.idfrais := nouveaucle_frais + 1;
EXCEPTION
when prenumber_frais then :new.idfrais := 1;
ENd;
/

----------------------3 eme question------------------------------

Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Arakaza','Florant',19,'jabe');
Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Ciza','Jean',22,'Kigobe');
Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Keza','Jeanne',19,'Bwiza');
Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Keza','Elle',25,'Kinindo');
Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Kimana','Beatrice',19,'Musaga');
Insert into etudiant(nometu,prenometu,ageetu,adressetu) values('Bukuru','Pierre',20,'Jabe');

Insert into frais(idetu,libellefrais,montant)  values(1,'Paiement du Minerval: 1er Tranche',300000);
Insert into frais(idetu,libellefrais,montant) values(5,'Achat des livres',50000);
Insert into frais(idetu,libellefrais,montant) values(5,'Paiement des frais de logement',70000);
Insert into frais(idetu,libellefrais,montant)  values(4,'Paiement des frais de logement',400000);
Insert into frais(idetu,libellefrais,montant)  values(6,'Paiement des frais de logement',600000);
Insert into frais(idetu,libellefrais,montant)  values(9,'Paiement des frais de logement',700000);
Insert into frais(idetu,libellefrais,montant) values(1,'Paiement du Minerval: 1er Tranche',300000);

Insert into frais(idetu,libellefrais,montant) values(1,'Paiement du Minerval: 1er Tranche',300000);



----------------------4 eme question------------------------------

Create or replace procedure insertion_num_montanttotal(numero number)
IS
    --numero_var number,
    montant_var number;
Begin

    Select sum(montant) into montant_var from frais WHERE idetu = numero;
    Insert into fraisEtudiant(numeroetudiantnumber,montant_totalnumber)  values(numero,montant_var);
  
End;
/

----------------------5 eme question------------------------------

SET SERVEROUTPUT ON;
Create or replace function voir_montant_total(numero number)
Return number
IS
    montant_var number;
Begin  
    Select sum(montant) into montant_var from frais where idetu=numero;
    Return montant_var;
End;
/

----------------------6 eme question------------------------------

Create or replace procedure suppr_etudiant_300000
IS
    idEtudiant number;
    --montant_var number
Begin
    SELECT idetu into idEtudiant FROM frais WHERE montant = 300000;
    DELETE FROM etudiant WHERE idetu = idEtudiant;
End;
/

-------Appel de fonctions et procedures---------

-------1---------

BEGIN
    insertion_num_montanttotal(5);
END;
/

select * from fraisEtudiant;

-------2---------
SET SERVEROUTPUT ON;
DECLARE
    montant_var number;
BEGIN
    montant_var := voir_montant_total(5);
    dbms_output.PUT_LINE(montant_var);
END;
/
-------3---------
BEGIN
    suppr_etudiant_300000;
END;
/

select * from etudiant;

----------------------7 eme question------------------------------

CREATE or REPLACE PACKAGE gestionEtudiant
IS
    
    procedure insertion_num_montanttotal(numero number);
    function voir_montant_total(numero number) Return number;
    procedure suppr_etudiant_300000;

END gestionEtudiant;
/

CREATE or REPLACE PACKAGE BODY gestionEtudiant
IS

    -------------------1 er procedure--------------------
    
    Procedure insertion_num_montanttotal(numero number)
    IS
        --numero_var number,
        montant_var number;
    Begin
    
        Select sum(montant) into montant_var from frais WHERE idetu = numero;
        Insert into fraisEtudiant(numeroetudiantnumber,montant_totalnumber)  values(numero,montant_var);
      
    End;
    
    -------------------2 eme function--------------------
    
    Function voir_montant_total(numero number) Return number
    IS
        montant_var number;
    Begin  
        Select sum(montant) into montant_var from frais where idetu=numero;
        Return montant_var;
    End;
    
    
    
    -------------------3 eme procedure--------------------
    
    Procedure suppr_etudiant_300000
    IS
        idEtudiant number;
        --montant_var number
    Begin
        SELECT idetu into idEtudiant FROM frais WHERE montant = 300000 ;
        DELETE FROM etudiant WHERE idetu = idEtudiant;
    End;

END gestionEtudiant;
/

--------------Appel au package:fonctions et procedures---------

-------1---------

BEGIN
    gestionEtudiant.insertion_num_montanttotal(5);
END;
/

select * from fraisEtudiant;

-------2---------

select * from frais;


SET SERVEROUTPUT ON;
DECLARE
    montant_var number;
BEGIN
    montant_var := gestionEtudiant.voir_montant_total(5);
    dbms_output.PUT_LINE(montant_var);
END;
/
-------3---------
BEGIN
    gestionEtudiant.suppr_etudiant_300000;
END;
/




