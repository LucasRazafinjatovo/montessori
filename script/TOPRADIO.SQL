CREATE TABLE PUB_TOP_RADIO_MERE
(
   ID            VARCHAR2 (50),
   DATY          DATE,
   CLIENT        VARCHAR2 (50),
   OBSERVATION   VARCHAR2 (500),
   REFERENCE     VARCHAR2 (100),
   RESPONSABLE   VARCHAR2 (50),
   ETAT          NUMBER (10)
)
NOCACHE
LOGGING;

CREATE TABLE PUB_TOP_RADIO_FILLE
(
   ID            VARCHAR2 (50),
   NOMCAMPAGNE   VARCHAR2 (100),
   NATURE        VARCHAR2 (100),
   DUREE         VARCHAR2 (50),
   PUBTYPE       VARCHAR2 (50),
   DATEDEBUT     DATE,
   DATEFIN       DATE,
   HEURE         VARCHAR2 (50),
   QUANTITE      NUMBER (10),
   ETAT          NUMBER (10),
   MERE          VARCHAR2 (50)
)
NOCACHE
LOGGING;

insert into PUB_PLAGE_HORAIRE values ('PLG004','PACK JOURNNEE','4','','');

CREATE SEQUENCE SEQ_pubtopradiomere
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
 ;
  
CREATE OR REPLACE FUNCTION GETSEQPUBTOPRADIOMERE
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_pubtopradiomere.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;

CREATE SEQUENCE SEQ_pubtopradiofille
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
 ;
  
CREATE OR REPLACE FUNCTION GETSEQPUBTOPRADIOFILLE
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_pubtopradiofille.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;
CREATE TABLE PUB_TOP_RADIO_DUREE
(
   ID      VARCHAR2 (50),
   VAL     VARCHAR2 (100),
   DESCE   VARCHAR2 (100)
)
NOCACHE
LOGGING;
insert into PUB_TOP_RADIO_DUREE values ('DUREE001','10','10');
insert into PUB_TOP_RADIO_DUREE values ('DUREE002','20','20');
insert into PUB_TOP_RADIO_DUREE values ('DUREE003','30','30');
insert into PUB_TOP_RADIO_DUREE values ('DUREE004','40','40');
insert into PUB_TOP_RADIO_DUREE values ('DUREE005','50','50');
insert into PUB_TOP_RADIO_DUREE values ('DUREE006','60','60');
insert into PUB_TOP_RADIO_DUREE values ('DUREE007','AUTRES','AUTRES');

create view pubradiolib as

select m.id, m.daty, c.NOM as client,m.observation,m.reference, a.val as responsable,
 m.etat from pub_top_radio_mere m, client c, agence a where m.CLIENT = c.IDCLIENT and a.ID = m.RESPONSABLE;

CREATE TABLE PUB_TOP_RADIO_HEURE
(
   ID      VARCHAR2 (50),
   VAL     VARCHAR2 (100),
   DESCE   VARCHAR2 (100)
)
NOCACHE
LOGGING;
insert into PUB_TOP_RADIO_HEURE values ('HEURE001','6h00','6h00');
insert into PUB_TOP_RADIO_HEURE values ('HEURE002','6h15','6h15');
insert into PUB_TOP_RADIO_HEURE values ('HEURE003','6h30','6h30');
insert into PUB_TOP_RADIO_HEURE values ('HEURE004','6h45','6h45');
insert into PUB_TOP_RADIO_HEURE values ('HEURE005','7h00','7h00');
insert into PUB_TOP_RADIO_HEURE values ('HEURE006','07h15','07h15');
insert into PUB_TOP_RADIO_HEURE values ('HEURE007','07h30','07h30');
insert into PUB_TOP_RADIO_HEURE values ('HEURE008','07h45','07h45');	
insert into PUB_TOP_RADIO_HEURE values ('HEURE009','08h00','08h00');	
insert into PUB_TOP_RADIO_HEURE values ('HEURE010','11h30','11h30');	
insert into PUB_TOP_RADIO_HEURE values ('HEURE011','12h00','12h00');
insert into PUB_TOP_RADIO_HEURE values ('HEURE012','12h15','12h15');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE013','13h00','13h00');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE014','13h30','13h30');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE015','13h45','13h45');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE016','18h00','18h00');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE017','18h15','18h15');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE018','18h30','18h30');		
 insert into PUB_TOP_RADIO_HEURE values ('HEURE019','18h45','18h45');		
insert into PUB_TOP_RADIO_HEURE values ('HEURE020','19h00','19h00');
insert into PUB_TOP_RADIO_HEURE values ('HEURE021','19h45','19h45');				
insert into PUB_TOP_RADIO_HEURE values ('HEURE022','20h00','20h00');				
insert into PUB_TOP_RADIO_HEURE values ('HEURE023','20h15','20h15');				
insert into PUB_TOP_RADIO_HEURE values ('HEURE024','20h30','20h30');		
alter table pub_radio_partenariat add nombre_spot number(10,2);		
create or replace view pub_radio_paiement1 as 
select
	pub.id, pub.daty, cl.nom as client, pub.observation, pub.reference, 
	ag.val as responsable,pub.nomcampagne, plg.designation as nature, pub.duree, tp.designation as pubtype, pub.heure, 
	sum(trf.montant * pub.nombre_spot) as montant, sum(nvl(mvt.credit,0)) as paie, 
	sum(trf.montant* pub.nombre_spot) - sum(nvl(mvt.credit,0)) as reste
from
	pub_radio_partenariat pub
	join tarif_pack_radio trf on pub.idtarif = trf.id
	join pub_type tp on pub.nature = tp.id
	join pub_plage_horaire plg on pub.pubtype = plg.id
	join agence ag on pub.responsable = ag.id 
	join client cl on pub.client = cl.idclient
	left join pub_radio_or por on por.idpub = pub.id
	left join ordonnerrecette orr on por.idfacture = orr.ded_id
	left join mvtcaisse mvt on mvt.idordre = orr.id
group by pub.id, pub.daty, cl.nom, pub.observation, pub.reference, 
	ag.val,pub.nomcampagne, plg.designation, pub.duree, tp.designation, pub.heure;