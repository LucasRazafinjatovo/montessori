CREATE OR REPLACE VIEW ETAT_FACTURE_PAYEE AS
SELECT
A.idFactureFournisseur as id,
B.nif as nif,
B.nom as nom,
B.numstat as numstat,
B.adresse as adresse,
(A.montantttc-A.idtva) as montantht,
A.idtva as tva,
A.montantttc,
A.designation as libelle,
A.daty as daty,
A.numfact as numfact,
sum(D.debit) as montant_paye
FROM
FACTUREFOURNISSEUR A 
JOIN CLIENT B ON A.idFournisseur = B.idclient
JOIN ORDONNERPAYEMENT C on A.idFactureFournisseur = C.ded_id
JOIN MVTCAISSE D ON C.id = D.idordre
GROUP BY D.idordre, A.idFactureFournisseur, B.nif, B.nom, B.numstat, B.adresse, A.idtva, A.designation, A.daty, A.numfact, A.montantttc, A.montantttc