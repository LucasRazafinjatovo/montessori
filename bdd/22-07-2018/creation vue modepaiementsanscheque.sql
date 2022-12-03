create view modepaiementsanscheque as 
select * from modepaiement where val != 'cheque';