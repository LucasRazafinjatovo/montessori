CREATE VIEW rubriqueprixentitelib AS
SELECT rubriqueprixentite.id, rubriqueprixentite.libelle, rubriqueprixentite.montant, beneficiaire.val,  rubriqueprixentite.daty
from  rubriqueprixentite join beneficiaire on rubriqueprixentite.entite = beneficiaire.id