CREATE OR REPLACE VIEW OPNONPAYELC
AS
   SELECT d.ID,
          d.ded_id,
          l.idligne,
          d.daty,
          d.montant,
          d.remarque,
          d.etat,
          d.paye,
          l.designation              AS designationlc,
          l.creditinitial,
          l.creditmodifier,
          l.montanteng,
          l.montantvis,
          l.montantfac,
          l.idtypeligne,
          l.numcompte,
          l.identite,
          l.iddirection,
          l.mois,
          l.annee,
          (flc.montantmere - d.paye) AS parution,
          fc.IDFOURNISSEUR,
          cast(NULL as date)                       AS date_paiement,
          cast(NULL as varchar2(50))                      AS typee
     FROM oppayementtous           d,
          facturefournisseurlc     flc,
          lclettre                 l,
          FACTUREFOURNISSEURLETTRE fc
    WHERE     d.ded_id = flc.id1
          AND d.IDLIGNE = l.idligne
          AND flc.ID2 = l.idligne
          AND d.montant != 0
          AND flc.ID1 = fc.IDFACTUREFOURNISSEUR
          AND d.paye = 0
/
