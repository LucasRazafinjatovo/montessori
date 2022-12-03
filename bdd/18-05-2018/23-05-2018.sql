
  CREATE OR REPLACE FORCE VIEW ETUDIANTLIB AS 
  select e.id, e.nom, e.prenom, e.datenaissance, e.chemin, e.pere, tp.val as proffpere, e.mere, tp2.val as profmere, e.adresse,
e.contact, e.mail, s.val as sexe, ec.val as entite, e.niveau, p.val as pays, '' as promotion, '' as daty, '' as numero, e.DATE_FIN as date_fin, 
e.DATE_DEBUT as date_debut, e.etat as etat
FROM etudiant e,typeprof tp,beneficiaire ec,pays p,typeprof tp2,sexe s
WHERE e.proffpere=tp.id and e.profmere=tp2.id and e.entite=ec.id and e.pays=p.id and e.sexe=s.id;
 
