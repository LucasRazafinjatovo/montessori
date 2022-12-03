CREATE OR REPLACE FORCE VIEW "VVLIGNE"."CLIENT_CONTACT" ("IDCLIENT", "NOM", "IDREGIME", "ADRESSE", "TELEPHONE", "FAX", "NUMSTAT", "NIF", "RC", "TP", "QUITTANCE", "TYPE_CONTACT", "SOUSTYPE_CONTACT") AS 
  SELECT 
    client.idclient,
    client.nom,
    client.idregime,
    client.adresse,
    client.telephone,
    client.fax,
    client.numstat,
    client.nif,
    client.rc,
    client.tp,
    client.quittance,
    typecontact.val as type_contact,
    soustypecontact.val as soustype_contact
FROM 
    client
JOIN typecontact on typecontact.id = client.type_contact
JOIN soustypecontact on soustypecontact.id = client.soustype_contact;