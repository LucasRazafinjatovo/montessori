
 create table annonce_topradio(
id varchar(100), 
nom_client varchar(100), 
nom_campagne varchar(100), 
typee varchar(100), 
duree varchar(100), 
date_debut date,
date_fin date,
reference_pub varchar(200),
confection_pub varchar(500),
plage_horaire varchar(500),
sous_plage_horaire varchar(500),

primary key(id)
)
;
CREATE SEQUENCE SEQ_annonce_topradio  START WITH 1  MAXVALUE 999999999999999999999999999  MINVALUE 1 ;
CREATE OR REPLACE FUNCTION GETSEQannoncetopradio
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_annonce_topradio.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;
 
 
  create table sous_plage_horaire(
id varchar(100), 
val varchar(100), 
desce varchar(100), 
 

primary key(id)
)
;


--------PUB RADIO ---------------
create table pub_topradiomere(
id varchar(100), 
nom_client varchar(100), 
date_saisie date,
reference_pub varchar(200),
responsable varchar(500),
observation varchar(500),
etat integer,
primary key(id)
)
;

CREATE SEQUENCE SEQ_pub_topradiomere  START WITH 1  MAXVALUE 999999999999999999999999999  MINVALUE 1 ;
CREATE OR REPLACE FUNCTION GETSEQpubtopradiomere
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_pub_topradiomere.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;
 create table pub_topradiofille(
id varchar(100), 
idmere varchar(100), 
nom_campagne varchar(100), 
nature_pub varchar(100), 
typee varchar(100), 
duree varchar(100), 
date_debut date,
date_fin date,
heure varchar(200),
quantite number(10,2),
etat integer, 

primary key(id)
);

CREATE SEQUENCE SEQ_pub_topradiofille  START WITH 1  MAXVALUE 999999999999999999999999999  MINVALUE 1 ;
CREATE OR REPLACE FUNCTION GETSEQpubtopradiofille
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_pub_topradiofille.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;
-----ATRETO IHANY NO IZY ------------------------------------------------------------
create or replace view op_analysemvtcaisse as 
select  o.daty, extract( month from o.daty) as mois,sum(o.montant) as montant,sum(m.debit) as momntantpaye,(sum(o.montant)-sum(m.debit) )as reste
from ordonnerpayement o,MVTCAISSE m 
where o.id=m.idordre
group by  o.daty, extract( month from o.daty) 
;

create or replace view or_analysemvtcaisse as 
select  o.daty, extract( month from o.daty) as mois,sum(o.montant)as montant,sum(m.credit) as momntantpaye,(sum(o.montant)-sum(m.credit) )as reste
from ORDONNERRECETTE o,MVTCAISSE m 
where o.id=m.idordre
 group by  o.daty, extract( month from o.daty) ;

create view analysemvtcaisse as 
select 
o.daty,o.mois,o.montant as montantop,o.momntantpaye as oppaye,o.reste as opreste,
r.montant as montantor,r.momntantpaye as orpaye,r.reste as orreste, 
(r.montant-o.montant) as prevu,(r.momntantpaye-o.momntantpaye) as pratique
from 
op_analysemvtcaisse o,or_analysemvtcaisse r
where
o.daty=r.daty
and
o.mois=r.mois
