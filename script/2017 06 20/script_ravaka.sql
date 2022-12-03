CREATE OR REPLACE VIEW OPPAYELC_TDP
(ID, DED_ID, IDLIGNE, DATY, MONTANT, 
 REMARQUE, ETAT, PAYE, DESIGNATIONLC, CREDITINITIAL, 
 CREDITMODIFIER, MONTANTENG, MONTANTVIS, MONTANTFAC, IDTYPELIGNE, 
 NUMCOMPTE, IDENTITE, IDDIRECTION, MOIS, ANNEE, 
 PARUTION, IDFOURNISSEUR, DATE_PAIEMENT, TYPEE)
AS 
SELECT d.ID, d.ded_id, l.idligne, d.daty, d.montant, d.remarque,
          d.etat, d.paye, l.designation AS designationlc, l.creditinitial,
          l.creditmodifier, l.montanteng, l.montantvis, l.montantfac,
          l.idtypeligne, l.numcompte, l.identite, l.iddirection, l.mois,
          l.annee, (flc.montantmere - d.paye),fc.IDFOURNISSEUR,
          nvl(tdp.date_paiement,d.daty),nvl(tdp.typee, 'prevu')
     FROM oppayementtous d
     join facturefournisseurlc flc on d.ded_id = flc.id1
     join lclettre l on d.IDLIGNE = l.idligne
     join FACTUREFOURNISSEURLETTRE fc on flc.ID2=l.idligne and flc.ID1=fc.IDFACTUREFOURNISSEUR
     left join type_date_paiement tdp on d.ID = tdp.idOP
    WHERE d.montant!=0
/

CREATE OR REPLACE VIEW OPPAYELCAVISER_TDP
(ID, DED_ID, IDLIGNE, DATY, MONTANT, 
 REMARQUE, ETAT, PAYE, DESIGNATIONLC, CREDITINITIAL, 
 CREDITMODIFIER, MONTANTENG, MONTANTVIS, MONTANTFAC, IDTYPELIGNE, 
 NUMCOMPTE, IDENTITE, IDDIRECTION, MOIS, ANNEE, 
 PARUTION, IDFOURNISSEUR, DATE_PAIEMENT, TYPEE)
AS 
SELECT d.ID, d.ded_id, l.idligne, d.daty, d.montant, d.remarque,
          d.etat, d.paye, l.designation AS designationlc, l.creditinitial,
          l.creditmodifier, l.montanteng, l.montantvis, l.montantfac,
          l.idtypeligne, l.numcompte, l.identite, l.iddirection, l.mois,
          l.annee, (flc.montantmere - d.paye),fc.IDFOURNISSEUR, nvl(tdp.date_paiement, d.daty),nvl(tdp.typee,'prevu')
     FROM oppayementtousAViser d
     join facturefournisseurlc flc on d.ded_id = flc.id1
     join lclettre l on d.IDLIGNE = l.idligne
     join factureFournisseurlettre fc on flc.ID1=fc.IDFACTUREFOURNISSEUR and flc.ID2=l.idligne
     left join type_date_paiement tdp on d.ID = tdp.idOP
    WHERE d.montant!=0
/

CREATE OR REPLACE VIEW OPPAYELCVISER_TDP
(ID, DED_ID, IDLIGNE, DATY, MONTANT, 
 REMARQUE, ETAT, PAYE, DESIGNATIONLC, CREDITINITIAL, 
 CREDITMODIFIER, MONTANTENG, MONTANTVIS, MONTANTFAC, IDTYPELIGNE, 
 NUMCOMPTE, IDENTITE, IDDIRECTION, MOIS, ANNEE, 
 PARUTION, IDFOURNISSEUR, DATE_PAIEMENT, TYPEE)
AS 
SELECT d.ID, d.ded_id, l.idligne, d.daty, d.montant, d.remarque,
          d.etat, d.paye, l.designation AS designationlc, l.creditinitial,
          l.creditmodifier, l.montanteng, l.montantvis, l.montantfac,
          l.idtypeligne, l.numcompte, l.identite, l.iddirection, l.mois,
          l.annee, (flc.montantmere - d.paye),fc.IDFOURNISSEUR, nvl(tdp.date_paiement,d.daty),nvl(tdp.typee,'prevu')
     FROM OPPAYEMENTTOUSVISER d
     join facturefournisseurlc flc on d.ded_id = flc.id1
     join lclettre l on d.IDLIGNE = l.idligne
     join factureFournisseurlettre fc on flc.ID1=fc.IDFACTUREFOURNISSEUR and flc.ID2=l.idligne
     left join type_date_paiement tdp on d.ID = tdp.idOP
    WHERE d.montant!=0
/



