CREATE OR REPLACE VIEW OPLCAVISER
(ID, DED_ID, IDLIGNE, DATY, MONTANT, 
 REMARQUE, ETAT, DESIGNATIONLC, CREDITINITIAL, CREDITMODIFIER, 
 MONTANTENG, MONTANTVIS, MONTANTFAC, IDTYPELIGNE, NUMCOMPTE, 
 IDENTITE, IDDIRECTION, MOIS, ANNEE, PARUTION)
AS 
SELECT d.ID, d.ded_id, l.idligne, d.daty, o.MONTANTMERE , d.remarque,
          d.etat, l.designation AS designationlc, l.creditinitial,
          l.creditmodifier, l.montanteng, l.montantvis, l.montantfac,
          l.idtypeligne, l.numcompte, l.identite, l.iddirection, l.mois,
          l.annee, l.parution
     FROM opaviser d, facturefournisseurlc flc, lclettre l, opfflc o
    WHERE d.ded_id = flc.id1
      AND flc.id2 = l.idligne
      AND o.id1 = d.ID
      AND o.id2 = flc.ID
/

