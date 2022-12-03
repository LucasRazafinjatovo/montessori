CREATE OR REPLACE FORCE VIEW "VVLIGNE"."SOUSTYPECONTACTLIBELLE" ("ID", "VAL", "DESCE") AS 
  SELECT 
    SOUSTYPECONTACT.ID,
    SOUSTYPECONTACT.VAL,
    TYPECONTACT.VAL AS DESCE
FROM 
    SOUSTYPECONTACT
JOIN TYPECONTACT ON TYPECONTACT.ID = SOUSTYPECONTACT.DESCE;