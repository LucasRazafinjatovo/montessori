CREATE OR REPLACE  VIEW OP_ANALYSEMVTCAISSE_MONTANT ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE", "ANNEE") AS 
select  
	o.daty, extract( month from o.daty) as mois,sum(o.montant) as montant,0,0, o.annee
from 
	OPPAYELC_TDP o
	group by  o.daty, extract( month from o.daty), o.annee ;
 

CREATE OR REPLACE  VIEW OP_ANALYSEMVTCAISSE_PAYE ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE", "ANNEE") AS 
select  
	o.daty, extract( month from o.daty) as mois,0,sum(nvl(o.debit,0)), 0, extract( year from o.daty) as annee
from 
	MVTCAISSETOUS o
	group by  o.daty, extract( month from o.daty), extract(year from o.daty) ;


CREATE OR REPLACE  VIEW OP_ANALYSEMVTCAISSE ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE","ANNEE") AS 
  select  
	daty, mois ,sum(montant),sum(MOMNTANTPAYE), (sum(montant)-sum(MOMNTANTPAYE)) as reste, annee from 
	(
	select  
		daty, mois ,montant,MOMNTANTPAYE, reste, annee
	from 
		OP_ANALYSEMVTCAISSE_MONTANT
	union
	select  
		daty, mois ,montant,MOMNTANTPAYE, reste, annee
	from 
		OP_ANALYSEMVTCAISSE_PAYE
	)
group by daty, mois, annee ;


CREATE OR REPLACE VIEW OR_ANALYSEMVTCAISSE_MONTANT ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE", "ANNEE") AS 
	select  
		o.daty, extract( month from o.daty) as mois,sum(o.montant) as montant,0,0, annee
	from 
		orlc o
		group by  o.daty, extract( month from o.daty), annee ;


CREATE OR REPLACE VIEW OR_ANALYSEMVTCAISSE_PAYE ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE","ANNEE") AS 
	select  
        o.daty, extract( month from o.daty) as mois,0,sum(nvl(o.credit,0)), 0, extract( year from o.daty) as annee
    from 
        MVTCAISSETOUS o
        group by  o.daty, extract( month from o.daty),extract( year from o.daty) ;
		
		
CREATE OR REPLACE VIEW OR_ANALYSEMVTCAISSE ("DATY", "MOIS", "MONTANT", "MOMNTANTPAYE", "RESTE", "ANNEE") AS 
  select  
	daty, mois ,sum(montant),sum(MOMNTANTPAYE), (sum(montant)-sum(MOMNTANTPAYE)) as reste, annee from 
(
	select  
		daty, mois ,montant,MOMNTANTPAYE, reste, annee
	from 
		OR_ANALYSEMVTCAISSE_MONTANT
	union
	select  
		daty, mois ,montant,MOMNTANTPAYE, reste, annee
	from 
		OR_ANALYSEMVTCAISSE_PAYE
)
group by daty, mois, annee ;



CREATE OR REPLACE VIEW ANALYSEMVTCAISSE2 ("DATY", "MOIS", "MONTANTOP", "OPPAYE", "OPRESTE", "MONTANTOR", "ORPAYE", "ORRESTE", "PREVU", "PRATIQUE","ANNEE") AS 
  select 
	o.daty,o.mois,cast(o.montant as number(20,2)) as montantop,cast(o.momntantpaye as number(20,2)) as oppaye,
	cast(o.reste as number(20,2)) as opreste,
	cast(r.montant as number(20,2)) as montantor,
	cast(r.momntantpaye as number(20,2)) as orpaye,
	cast(r.reste as number(20,2)) as orreste, 
	(r.montant-o.montant) as prevu,(r.momntantpaye-o.momntantpaye) as pratique,
	o.annee
	from 
		op_analysemvtcaisse o,or_analysemvtcaisse r 
	where
		o.daty=r.daty(+)
	and
		o.mois=r.mois(+) ;