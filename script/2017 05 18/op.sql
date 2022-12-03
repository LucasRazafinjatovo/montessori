CREATE OR REPLACE  VIEW OP_A_ANNULER ("ID", "MONTANT", "MONTANT_PAYE", "RESTE") AS 
  select op.id,
op.montant,
mvt.sommemontant
as montant_paye,
op.montant-mvt.sommemontant
as reste 
from  ordonnerpayement op 
join visaordrepayement v on op.id=v.idobjet 
join MVTCAISSESOMMEDEBIT mvt on op.id=mvt.id where op.montant-mvt.sommemontant >=100;
 

 
