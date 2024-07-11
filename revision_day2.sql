CREATE TABLE ETUDIANT (
    ID_ETUDIANT NUMBER(5) PRIMARY KEY,
    NOM VARCHAR2(50),
    PRENOM VARCHAR2(50),
    DATE_NAISSANCE DATE,
    EMAIL VARCHAR2(100),
    TELEPHONE VARCHAR2(20),
    SEXE CHAR(1), -- M pour masculin, F pour féminin
    ADRESSE VARCHAR2(200),
    VILLE VARCHAR2(50),
    CODE_POSTAL VARCHAR2(10),
    PAYS VARCHAR2(50),
    DEPARTEMENT VARCHAR2(50),
    NIVEAU_ETUDE VARCHAR2(50),
    DATE_INSCRIPTION DATE,
    NOTE_MOYENNE NUMBER(4,2),
    ACTIVITE_EXTRA VARCHAR2(100),
    BOURSIER CHAR(1), -- O pour oui, N pour non
    COMMENTAIRES VARCHAR2(500)
);

-- Insérer 5 étudiants dans la table ETUDIANT
INSERT INTO ETUDIANT (ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES (1, 'Dupont', 'Jean', TO_DATE('1995-06-15', 'YYYY-MM-DD'), 'jean.dupont@example.com', '0123456789', 'M', '10 Rue de Paris', 'Paris', '75001', 'France', 'Informatique', 'Licence', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 15.75, 'Football', 'O', 'Étudiant sérieux');

INSERT INTO ETUDIANT (ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES (2, 'Martin', 'Sophie', TO_DATE('1996-07-22', 'YYYY-MM-DD'), 'sophie.martin@example.com', '0987654321', 'F', '20 Avenue des Champs', 'Lyon', '69002', 'France', 'Économie', 'Master', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 14.25, 'Danse', 'N', 'Participante active');

INSERT INTO ETUDIANT (ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES (3, 'Durand', 'Luc', TO_DATE('1997-08-10', 'YYYY-MM-DD'), 'luc.durand@example.com', '0678901234', 'M', '15 Boulevard de la République', 'Marseille', '13001', 'France', 'Mathématiques', 'Doctorat', TO_DATE('2018-09-01', 'YYYY-MM-DD'), 16.50, 'Échecs', 'N', 'Très bon en recherche');

INSERT INTO ETUDIANT (ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES (4, 'Petit', 'Emma', TO_DATE('1998-09-05', 'YYYY-MM-DD'), 'emma.petit@example.com', '0543219876', 'F', '5 Place de la Bourse', 'Bordeaux', '33000', 'France', 'Biologie', 'Licence', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 13.80, 'Théâtre', 'O', 'Aime les sciences naturelles');

INSERT INTO ETUDIANT (ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES (5, 'Leroy', 'Paul', TO_DATE('1999-10-30', 'YYYY-MM-DD'), 'paul.leroy@example.com', '0765432198', 'M', '25 Rue des Lilas', 'Nantes', '44000', 'France', 'Physique', 'Master', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 17.00, 'Musique', 'N', 'Excellent en physique');



set SERVEROUTPUT ON
Declare 
Nom_etud Etudiant.NOM%Type ;
Nom_etud1 Etudiant.NOM%Type ;
 Cursor C Is Select NOM From Etudiant Where ID_ETUDIANT=5; 
Begin 
 Open C ;

 Fetch C Into Nom_etud;
    DBMS_OUTPUT.PUT_LINE('Nom avant modification : '||Nom_etud);
    update Etudiant SET NOM = 'Patrick' WHERE ID_ETUDIANT=5;
    
    Select NOM Into Nom_etud1 From Etudiant Where ID_ETUDIANT=5;
    DBMS_OUTPUT.PUT_LINE('Nom apres modification : '||Nom_etud1);

 Close C ;
End ; 
/




CREATE OR REPLACE FUNCTION CHANGENBPERSONNES (
     RECETTE      IN   INT,
     NBPERSONNE   IN   INT)
     RETURN TABLE_RES
AS
     CURSOR CURSEUR_ETAPE
     IS
          SELECT  TABLE_RES_OBJ (IR.*)
            FROM INGREDIENTRECETTE IR 
            JOIN RECETTE R ON IR.IDRECETTE =R.IDRECETTE
                 JOIN INGREDIENT I ON IR.IDINGREDIENT = I.IDINGREDIENT
           WHERE R.IDRECETTE = RECETTE;

     VAR       TABLE_RES:= TABLE_RES();
BEGIN
     OPEN CURSEUR_ETAPE;

     LOOP
          FETCH CURSEUR_ETAPE
          BULK COLLECT INTO VAR LIMIT 100;

          EXIT WHEN CURSEUR_ETAPE%NOTFOUND;
     END LOOP;

     CLOSE CURSEUR_ETAPE;

     RETURN VAR;
END;
/
Or as per @a_horse_with_no_name, Using PipeLine Function, it could be as below:

CREATE OR REPLACE FUNCTION Moins35ans
   RETURN TABLE_RES
   PIPELINED
IS
   CURSOR CURSEUR_DES_moins_de_35
   IS
      SELECT * FROM ETUDIANT WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, DATE_NAISSANCE) / 12) <= 35;
BEGIN
   FOR i IN CURSEUR_DES_moins_de_35
   LOOP
      PIPE ROW (TABLE_RES_OBJ (ID_ETUDIANT,NOM,PRENOM,DATE_NAISSANCE,EMAIL));
      EXIT WHEN CURSEUR_DES_moins_de_35%NOTFOUND;
   END LOOP;

   RETURN;
END;
/




CREATE OR REPLACE FUNCTION afficher_etudiants_moins_de_30_ans
RETURN SYS_REFCURSOR
IS
    etudiants SYS_REFCURSOR;
BEGIN
    OPEN etudiants FOR
    SELECT ID_ETUDIANT, NOM, PRENOM, DATE_NAISSANCE, EMAIL, 
    TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, 
    DEPARTEMENT,NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, 
    ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES
    FROM ETUDIANT
    WHERE (MONTHS_BETWEEN(SYSDATE, DATE_NAISSANCE) / 12) < 30;

    RETURN etudiants;
END afficher_etudiants_moins_de_30_ans;
/


BEGIN
afficher_etudiants_moins_de_30_ans;
END;
/



DECLARE
    cur SYS_REFCURSOR;
    v_id_etudiant ETUDIANT.ID_ETUDIANT%TYPE;
    v_nom ETUDIANT.NOM%TYPE;
    v_prenom ETUDIANT.PRENOM%TYPE;
    v_date_naissance ETUDIANT.DATE_NAISSANCE%TYPE;
    v_email ETUDIANT.EMAIL%TYPE;
    v_telephone ETUDIANT.TELEPHONE%TYPE;
    v_sexe ETUDIANT.SEXE%TYPE;
    v_adresse ETUDIANT.ADRESSE%TYPE;
    v_ville ETUDIANT.VILLE%TYPE;
    v_code_postal ETUDIANT.CODE_POSTAL%TYPE;
    v_pays ETUDIANT.PAYS%TYPE;
    v_departement ETUDIANT.DEPARTEMENT%TYPE;
    v_niveau_etude ETUDIANT.NIVEAU_ETUDE%TYPE;
    v_date_inscription ETUDIANT.DATE_INSCRIPTION%TYPE;
    v_note_moyenne ETUDIANT.NOTE_MOYENNE%TYPE;
    v_activite_extra ETUDIANT.ACTIVITE_EXTRA%TYPE;
    v_boursier ETUDIANT.BOURSIER%TYPE;
    v_commentaires ETUDIANT.COMMENTAIRES%TYPE;
BEGIN
    cur := afficher_etudiants_moins_de_30_ans;

    LOOP
        FETCH cur INTO v_id_etudiant, v_nom, v_prenom, v_date_naissance, v_email, v_telephone, v_sexe, v_adresse, v_ville, v_code_postal, v_pays, v_departement, v_niveau_etude, v_date_inscription, v_note_moyenne, v_activite_extra, v_boursier, v_commentaires;
        EXIT WHEN cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_etudiant || ', Name: ' || v_nom || ' ' || v_prenom);
        -- You can add more output lines for other columns if needed.
    END LOOP;
    
    CLOSE cur;
END;
/


BEGIN 

END;
/


create or replace package GestionEtudiant
is
procedure supprEtudiant(etudiant_id ETUDIANT.ID_ETUDIANT%type);

procedure update_etudiant_email(etudiant_id ETUDIANT.ID_ETUDIANT%type,new_etudiant_email ETUDIANT.EMAIL%type);

function afficher_etudiant(etudiant_id ETUDIANT.ID_ETUDIANT%type) RETURN ETUDIANT%rowtype;

function modifier_etudiant_note(etudiant_id ETUDIANT.ID_ETUDIANT%type,new_etudiant_note ETUDIANT.NOTE_MOYENNE%type) RETURN ETUDIANT.NOTE_MOYENNE%type;

end GestionEtudiant;
/


create or replace package BODY GestionEtudiant
is
procedure supprEtudiant(etudiant_id ETUDIANT.ID_ETUDIANT%type)
is
    begin
        DELETE from ETUDIANT WHERE ID_ETUDIANT = etudiant_id;
    end;

procedure update_etudiant_email(etudiant_id ETUDIANT.ID_ETUDIANT%type,new_etudiant_email ETUDIANT.EMAIL%type)
is
    begin
        Update ETUDIANT SET EMail = new_etudiant_email WHERE ID_ETUDIANT = etudiant_id;
    end;

function afficher_etudiant(etudiant_id ETUDIANT.ID_ETUDIANT%type) RETURN ETUDIANT%rowtype
is
l_etudiant ETUDIANT%rowtype;
begin
    select * into l_etudiant from ETUDIANT where ID_ETUDIANT = etudiant_id;
    return l_etudiant;
end;

function modifier_etudiant_note(etudiant_id ETUDIANT.ID_ETUDIANT%type,new_etudiant_note ETUDIANT.NOTE_MOYENNE%type) RETURN ETUDIANT.NOTE_MOYENNE%type
is 
note ETUDIANT.NOTE_MOYENNE%type;
begin
    Update ETUDIANT set NOTE_MOYENNE = new_etudiant_note WHERE ID_ETUDIANT = etudiant_id;
    Return new_etudiant_note;
end;

end GestionEtudiant;
/


BEGIN 
GestionEtudiant.supprEtudiant(5);
END;
/

DECLARE
note ETUDIANT.NOTE_MOYENNE%type;
BEGIN 

note = GestionEtudiant.modifier_etudiant_note(4,13.5);
DBMS_OUTPUT.PUT_LINE('Note: '||note);

END;
/



DECLARE
note ETUDIANT.NOTE_MOYENNE%type;
BEGIN 

note := GestionEtudiant.modifier_etudiant_note(4,12.4);
DBMS_OUTPUT.PUT_LINE('Note: '||note);

END;
/



create or replace trigger cleauto_etudiant
before insert on Etudiant
for each row
declare
nombre integer;
nouveaucle integer;
premierCle exception;
begin
select count(*) into nombre from Etudiant;
if nombre=0 then
raise premierCle;-- Premiere insertion
end if;
select max(ID_Etudiant) into nouveaucle from Etudiant;
:new.ID_Etudiant := nouveaucle+1;
exception
when premierCle then :new.ID_Etudiant := 1;
end;
/


INSERT INTO ETUDIANT ( NOM, PRENOM, DATE_NAISSANCE, EMAIL, TELEPHONE, SEXE, ADRESSE, VILLE, CODE_POSTAL, PAYS, DEPARTEMENT, NIVEAU_ETUDE, DATE_INSCRIPTION, NOTE_MOYENNE, ACTIVITE_EXTRA, BOURSIER, COMMENTAIRES) 
VALUES ('Dupont', 'Jean', TO_DATE('1995-06-15', 'YYYY-MM-DD'), 'jean.dupont@example.com', '0123456789', 'M', '10 Rue de Paris', 'Paris', '75001', 'France', 'Informatique', 'Licence', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 15.75, 'Football', 'O', 'Étudiant sérieux');

