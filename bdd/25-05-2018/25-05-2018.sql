create or replace view etudiant_actif as
SELECT ETUDIANT.ID,"NOM","PRENOM","DATENAISSANCE","PERE","PROFFPERE","MERE","PROFMERE","ADRESSE","CONTACT","MAIL","CHEMIN","SEXE","ENTITE","NIVEAU","PAYS","ETAT","DATE_FIN","DATE_DEBUT" 
FROM ETUDIANT join MOUVEMENTETUDIANT ON ETUDIANT.ID = MOUVEMENTETUDIANT.ETUDIANT WHERE MOUVEMENTETUDIANT.TYPE = 1
 
create or replace view etudiant_inactif as
SELECT ETUDIANT.ID,"NOM","PRENOM","DATENAISSANCE","PERE","PROFFPERE","MERE","PROFMERE","ADRESSE","CONTACT","MAIL","CHEMIN","SEXE","ENTITE","NIVEAU","PAYS","ETAT","DATE_FIN","DATE_DEBUT" 
FROM ETUDIANT join MOUVEMENTETUDIANT ON ETUDIANT.ID = MOUVEMENTETUDIANT.ETUDIANT WHERE MOUVEMENTETUDIANT.TYPE = 0


CREATE OR REPLACE VIEW ETAT_PAIEMENT AS
SELECT EDITION.IDETUDIANT, ETUDIANT.NOM, ETUDIANT.PRENOM, CONFPRIXETUDIANT.ECHEANCE, MOIS_ANG.VAL AS MOIS, EDITION.ANNEE, ENTITE_BENEFICIAIRE.VAL AS ECOLE, 
EDITION.FOODDU, EDITION.FOODPAYE, EDITION.ECOLAGEDU, EDITION.ECOLAGEPAYE, EDITION.TRANSPORTDU, EDITION.TRANSPORTPAYE, 
EDITION.INSCRIPTIONDU, EDITION.INSCRIPTIONPAYE, EDITION.AUTREDU, EDITION.AUTREPAYE, (EDITION.FOODDU + EDITION.ECOLAGEDU + EDITION.TRANSPORTDU + EDITION.INSCRIPTIONDU + EDITION.AUTREDU) AS MONTANTDU,
(EDITION.FOODPAYE + EDITION.ECOLAGEPAYE + EDITION.TRANSPORTPAYE + EDITION.INSCRIPTIONPAYE + EDITION.AUTREPAYE) AS MONTANTPAYE, ((EDITION.FOODDU + EDITION.ECOLAGEDU + EDITION.TRANSPORTDU + EDITION.INSCRIPTIONDU + EDITION.AUTREDU) - (EDITION.FOODPAYE + EDITION.ECOLAGEPAYE + EDITION.TRANSPORTPAYE + EDITION.INSCRIPTIONPAYE + EDITION.AUTREPAYE)) AS RESTE
FROM EDITION JOIN CONFPRIXETUDIANT on EDITION.IDETUDIANT = CONFPRIXETUDIANT.ETUDIANT
JOIN ETUDIANT ON ETUDIANT.ID = EDITION.IDETUDIANT
JOIN ENTITE_BENEFICIAIRE ON ENTITE_BENEFICIAIRE.ID = ETUDIANT.ENTITE
JOIN MOIS_ANG ON MOIS_ANG.ID = EDITION.MOIS
GROUP BY 
EDITION.IDETUDIANT, ETUDIANT.NOM, ETUDIANT.PRENOM, CONFPRIXETUDIANT.ECHEANCE, MOIS_ANG.VAL , EDITION.ANNEE, ENTITE_BENEFICIAIRE.VAL, 
EDITION.FOODDU, EDITION.FOODPAYE, EDITION.ECOLAGEDU, EDITION.ECOLAGEPAYE, EDITION.TRANSPORTDU, EDITION.TRANSPORTPAYE, 
EDITION.INSCRIPTIONDU, EDITION.INSCRIPTIONPAYE, EDITION.AUTREDU, EDITION.AUTREPAYE


create table typerubrique(
	id character varying(100) PRIMARY KEY NOT NULL,
	val character varying(150),
	desce character varying(150)
);
insert into typerubrique values ('1','Ecolage','Ecolage');
insert into typerubrique values ('2','Food','Food');
insert into typerubrique values ('3','Transport','Transport');
insert into typerubrique values ('4','Inscription','Inscription');


CREATE OR REPLACE VIEW EDITION_ETUDIANT AS 
select idetudiant, sum(ecolagedu) as ecolagedu, sum(ecolagepaye) as ecolagepaye, sum(fooddu) as fooddu, sum(foodpaye) as foodpaye, sum(transportdu) as transportdu, sum(transportpaye) as transportpaye, sum(inscriptiondu) as inscriptiondu, sum(inscriptionpaye) as inscriptionpaye, sum(autredu) as autredu, sum(autrepaye) as autrepaye from edition group by idetudiant 

create table mois_ang(
	id character varying(100) PRIMARY KEY NOT NULL,
	val character varying(150),
	desce character varying(150)
);
insert into mois_ang values ('1','January','Janvier');
insert into mois_ang values ('2','February','Février');
insert into mois_ang values ('3','March','Mars');
insert into mois_ang values ('4','April','Avril');
insert into mois_ang values ('5','May','Mai');
insert into mois_ang values ('6','June','Juin');
insert into mois_ang values ('7','July','Juillet');
insert into mois_ang values ('8','August','Aout');
insert into mois_ang values ('9','September','Septembre');
insert into mois_ang values ('10','October','Octobre');
insert into mois_ang values ('11','November','Novembre');
insert into mois_ang values ('12','December','Décembre');

create or replace view mois_anglais as
select * from mois_ang order by id