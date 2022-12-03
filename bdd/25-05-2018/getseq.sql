create or replace 
FUNCTION getSeqpaiement_detail RETURN NUMBER IS retour NUMBER;
  BEGIN
  SELECT SEQPAIEMENT_DETAIL.nextval INTO retour FROM dual;
return retour;
END;