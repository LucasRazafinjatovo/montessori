
UPDATE devise
SET val = 'ZAR',
    desce = 'Rand'
WHERE id= 'Ar';

alter table paiment_detail add numero_cheque varchar2(100);