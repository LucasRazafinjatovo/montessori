create table niveau(
    id varchar(50) not null primary key,
    nom varchar(150) 
);
create TABLE anneescolaire(
    id varchar(50) not null primary key,
    nom varchar(150) 
);
create table anneeencours(
    id varchar(50) not null primary key,
    nom varchar(150) 
);
CREATE SEQUENCE seq_niveau INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqniveau
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_niveau.nextval INTO retour FROM dual;
  return retour;
END;

CREATE SEQUENCE seq_anneescolaire INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqanneescolaire
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_anneescolaire.nextval INTO retour FROM dual;
  return retour;
END;
ALTER TABLE ecole ADD CONSTRAINT pk_ecole PRIMARY KEY (id);

CREATE TABLE tarif(
    id VARCHAR2(50) not null PRIMARY key,
    designation VARCHAR(100),
    montant NUMBER(30,2),
    idecole VARCHAR(100),
    foreign KEY(idecole) REFERENCES ecole(id)
);
CREATE TABLE choixtarif(
    id VARCHAR2(50) not null PRIMARY key,
    designation VARCHAR(100)
);
CREATE SEQUENCE seq_tarif INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqtarif
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_tarif.nextval INTO retour FROM dual;
  return retour;
END;
CREATE TABLE inscriptionetudiant
(	
    id VARCHAR2(50) NOT NULL primary key, 
    moisdebut int,
	idetudiant VARCHAR2(100),
	idniveau VARCHAR2(100),
    idanneescolaire VARCHAR2(100),
    idecole VARCHAR2(50),
    idtarif VARCHAR2(50),
    foreign key(idetudiant) REFERENCES etudiant(id),
    foreign KEY(idniveau) REFERENCES niveau(id),
    foreign KEY(idanneescolaire) REFERENCES anneescolaire(id),
    foreign KEY(idecole) REFERENCES ecole(id),
    foreign KEY(idtarif) REFERENCES tarif(id)
);
CREATE SEQUENCE seq_inscriptionetudiant INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqinscriptionetudiant
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_inscriptionetudiant.nextval INTO retour FROM dual;
  return retour;
END;

CREATE TABLE abondantetudiant
(	
    id VARCHAR2(50) NOT NULL primary key,
    motif VARCHAR2(100), 
    mois int,
    annee int,
  	idetudiant VARCHAR2(100),
    foreign key(idetudiant) REFERENCES etudiant(id)
);
CREATE SEQUENCE seq_abondantetudiant INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqabondantetudiant
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_abondantetudiant.nextval INTO retour FROM dual;
  return retour;
END;
---------------------------------------------------------------------------------------
create table facturemere(
    id VARCHAR2(50) not null PRIMARY key,
    mois int,
    annee int,
    idetudiant VARCHAR2(100),
    foreign key(idetudiant) REFERENCES etudiant(id)
);
CREATE SEQUENCE seq_facturemere INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqfacturemere
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_facturemere.nextval INTO retour FROM dual;
  return retour;
END;

create table facturefille(
    id VARCHAR2(50) not null PRIMARY key,
    designation VARCHAR(100),
    montant NUMBER(30,2),
    idfacturemere VARCHAR2(100),
    foreign key(idfacturemere) REFERENCES facturemere(id)
);
CREATE SEQUENCE seq_facturefille INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqfacturefille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_facturefille.nextval INTO retour FROM dual;
  return retour;
END;
----------------------------------------------------------------------
create table caisse_c(
    id varchar(50) not null primary key,
    desccaisse varchar(150) 
);
create table paiement(
    id VARCHAR2(50) not null PRIMARY key,
    montant NUMBER(30,2),
    datepaiement date,
    idfacture VARCHAR2(50),
    idmodepaiement VARCHAR2(100),
    idcaisse VARCHAR2(100),
    foreign key(idfacture) REFERENCES facturefille(id),
    foreign key(idmodepaiement) REFERENCES modepaiement(id),
    foreign key(idcaisse) REFERENCES caisse(idcaisse)
);
CREATE SEQUENCE seq_paiement INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqpaiement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_paiement.nextval INTO retour FROM dual;
  return retour;
END;
------------------------------------------------------------------------
create table typedepense(
  id varchar(50) not null primary key,
  val varchar(150),
  desce VARCHAR(150)
);
CREATE TABLE depense(
  id varchar(50) not null primary key,
  daty date,
  designation VARCHAR2(100),
  montant NUMBER(30,2),
  beneficiaire VARCHAR2(100),
    idtypedepense VARCHAR2(100),
    idcaisse VARCHAR2(100),
    idecole VARCHAR2(50),
    foreign key(idtypedepense) REFERENCES typedepense(id),
    foreign key(idcaisse) REFERENCES caisse(idcaisse),
     foreign key(idecole) REFERENCES ecole(id)
);
CREATE SEQUENCE seq_depense INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqdepense
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_depense.nextval INTO retour FROM dual;
  return retour;
END;
------------------------------------------------
create table mvtcaisse(
    id varchar(50) not null primary key,
  daty date,
  designation VARCHAR2(100),
  debit NUMBER(30,2),
  credit NUMBER(30,2),
  idcaisse VARCHAR2(100),
  idmodepaiement VARCHAR2(100),
  idecole VARCHAR2(50),
  foreign key(idmodepaiement) REFERENCES modepaiement(id),
  foreign key(idcaisse) REFERENCES caisse(idcaisse),
  foreign key(idecole) REFERENCES ecole(id)
);
CREATE SEQUENCE seq_mvtcaisse INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqmvtcaisse
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_mvtcaisse.nextval INTO retour FROM dual;
  return retour;
END;



CREATE TABLE report 
   (	
    id VARCHAR2(50) not null primary key, 
	daty DATE, 
	montant NUMBER(25,2), 
	idcaisse VARCHAR2(50),
	idecole varchar2(50),
  FOREIGN key(idcaisse) REFERENCES caisse(idcaisse),
    FOREIGN key(idecole) REFERENCES ecole(id)
   );
   CREATE SEQUENCE seq_report INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999999999999999999 NOCYCLE NOCACHE NOORDER;
CREATE FUNCTION getseqreport
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_report.nextval INTO retour FROM dual;
  return retour;
END;