CREATE OR REPLACE FORCE VIEW "VVLIGNE"."BALANCE_GROUPE" ("EXERCICE", "DATEDEBUT", "DATEFIN", "SOCIETE", "COMPTE", "INTITULE", "INITDEBIT", "INITCREDIT", "MVTDEBIT", "MVTCREDIT", "DATY", "ECHEANCE", "SOLDEDEBIT", "SOLDECREDIT") AS 
  select exercice.id as exercice, exercice.datedebut, 
exercice.datefin, societe.nom as societe,
 CAST (compte AS number(20,0)) as compte, 
	comptecomptabilite.desce as intitule,
	cast(0 as number(20,2)) as initdebit, cast(0 as number(20,2)) as initcredit, 
	cast ( case 
		when montantcredit<0 and montantdebit=0 then montantcredit*-1
    when montantdebit>0 then montantdebit
		else 0
	end as number(20,2)) as mvtdebit,
   cast ( case 
		when montantdebit<0 and montantcredit=0 then montantdebit*-1
    when montantcredit>0 then montantcredit
		else 0
	end as number(20,2)) as mvtcredit, daty, echeance,
	cast ( case 
		when montantdebit-montantcredit>0 then montantdebit-montantcredit
		else 0
	end as number(20,2)) as soldedebit,
	cast (case 
		when montantcredit-montantdebit>0 then montantcredit-montantdebit
		else 0
	end as number(20,2)) as soldecredit
from ecriturecompta 
join comptecomptabilite on comptecomptabilite.val = ecriturecompta.compte
join societe on societe.id = ecriturecompta.societe
join exercice on exercice.id = ecriturecompta.exercice
where ecriturecompta.etat = 0;