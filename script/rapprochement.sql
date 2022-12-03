CREATE TABLE COMPTA_LETTRAGE_RAPPRO
   (	id VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	ID_COMPTE_TIERS VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	EXERCICE VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	LETTRE VARCHAR2(50 BYTE) NOT NULL ENABLE, 
   PRIMARY KEY ("ID")
   ) ;
   CREATE SEQUENCE  
   SEQ_COMPTA_LETTRAGE_RAPPRO  
   MINVALUE 1 MAXVALUE 999999999999999999999999999
   INCREMENT BY 1 START WITH 6 NOCACHE  NOORDER  NOCYCLE ;
   create or replace 
FUNCTION        GETSEQCOMPTALETTRAGERAPPRO
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_COMPTA_LETTRAGE_RAPPRO.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 
CREATE TABLE RAPPRO_LETTRE
   (	ID VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	LETTRE VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	DATELETTRAGE DATE, 
	TYPELETTRAGE VARCHAR2(255 BYTE), 
	 PRIMARY KEY ("ID")
   );
    CREATE SEQUENCE  SEQ_RAPPRO_LETTRE  
    MINVALUE 1 MAXVALUE 999999999999999999999999999 
    INCREMENT BY 1 START WITH 215 NOCACHE  NOORDER  NOCYCLE ;
    create or replace 
FUNCTION        GETSEQRAPPROLETTRE 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seq_rappro_lettre.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

create view RIBNONRAPPROCHE (ID, NUMCHEQUE, NUMREFERENCE, REMARQUE, DATY, DESIGNATION, DEBIT, CREDIT, TYPE, CAISSE) AS
select
  ts.ID, ts.NUMCHEQUE, ts.NUMREFERENCE, ts.REMARQUE, ts.DATY, ts.DESIGNATION, ts.DEBIT, ts.CREDIT, ts.TYPE, c.idcaisse
from
  rapro_sous_releve rap, RIB ts, caisse c
where
  ts.caisse = c.idcaisse and 
  rap.ID(+) = ts.ID and rap.ID is null ;

create view MVTNONRAPPROCHE (ID, DATY, DESIGNATION, DEBIT, CREDIT, IDDEVISE, IDMODE, IDCAISSE, REMARQUE, AGENCE, TIERS, NUMPIECE, TYPEMVT, DATYVALEUR, IDORDRE, NUMCHEQUE, ETABLISSEMENT) AS
select
  m.ID, m.daty, m.designation, cast(sum(m.debit) as number(20,2)), CAST(sum(m.credit) as number(20,2)), m.iddevise,
mp.val, c.desccaisse, CAST(m.remarque as varchar2(3000)),
CAST(a.val as varchar2(500)), m.tiers, m.numpiece, t.val,
m.datyvaleur, mv.idor,CAST(m.numcheque as varchar2(500)),CAST(m.etablissement as varchar2(500))
from
  mvtcaissevalide m, typemvt t, agence a, caisse c, 
  modepaiement mp, mvtor mv, rappro_sous_mvtcaisse r,  
  retourmonnaiemvtcaisse retour
where
  m.typemvt = t.ID AND 
  m.agence = a.ID  AND 
  m.idcaisse = c.idcaisse AND 
  m.idmode = mp.ID AND
  m.idmvtor = mv.ID 
  and m.ID = r.idmvtcaisse(+) and r.idmvtcaisse is null
  and m.ID = retour.ID2(+) and retour.ID2 is null
  group by 
  m.ID, m.daty, m.designation, m.iddevise,
  mp.val, c.desccaisse, m.remarque,
  a.val, m.tiers, m.numpiece, t.val,
  m.datyvaleur, mv.idor,m.numcheque,m.etablissement ;

CREATE OR REPLACE FORCE VIEW ETATCAISSE (DATY, DEVISE, CAISSE, DEBIT, CREDIT, MONTANTBRUT, PLAFONNEMENT, REPORT, DISPONIBLENET) AS 
  SELECT
    jma.DATY,
    'AR', 
    ca.DESCCAISSE as CAISSE,
    case when jma.RESPCAISSE = 1 then cast(NVL(SUM(mvt.DEBIT),0) as number(15,2)) else cast(0 as number(15,2)) end, 
    case when jma.RESPCAISSE = 1 then cast(NVL(SUM(mvt.CREDIT),0)as number(15,2)) else cast(0 as number(15,2)) end,
    0, 
    cast(NVL((SELECT  sum(pl.MONTANT) keep (dense_rank first order by pl.DATYEFFECTIVE desc) FROM plafonnement pl WHERE pl.IDCAISSE = mvt.IDCAISSE and pl.DATYEFFECTIVE <= jma.DATY),0)as number(15,2))
    , 0, 
    cast(NVL((SUM(mvt.CREDIT) - SUM(mvt.DEBIT)) + (SELECT  sum(pl.MONTANT) keep (dense_rank first order by pl.DATYEFFECTIVE desc) FROM plafonnement pl WHERE pl.IDCAISSE = mvt.IDCAISSE and pl.DATYEFFECTIVE <= jma.DATY),0)as number(15,2))
FROM
    mvtcaisse mvt,
    caisse ca,
    jourmoisanneecaisseg jma,
    rappro_sous_mvtcaisse rp
WHERE
    ca.IDCAISSE(+)=jma.IDCAISSE
    and mvt.IDCAISSE(+)=jma.IDCAISSE and mvt.DATY(+)=jma.DATY
    and extract(YEAR from jma.DATY) >= (SELECT EXTRACT(YEAR FROM SYSDATE) FROM dual) - 1
    and mvt.ID =  rp.idmvtcaisse(+) and rp.idmvtcaisse is null
GROUP BY
    jma.DATY, mvt.IDCAISSE, ca.desccaisse, jma.RESPCAISSE
ORDER BY jma.DATY DESC ;

/* insertion données pour migration*/
  insert into rappro_lettre values ('RPL00000','migration','06/04/2017','auto');
  /* ==================================== migration données ============================= */
  
  insert into rappro_sous_mvtcaisse select getseqrapprosousmvtcaisse(), 'RPL00000', r.idmouvement from rapprochement r;
  insert into rappro_sous_releve select getseqrapprosousreleve(), 'RPL00000', r.idrib from rapprochement r;