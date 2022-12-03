

create or replace view entite_beneficiaire as
select b.id, b.val, b.desce, s.id as idSociete from societe s 
join SOCIETEENTITE se on s.id = se.idsociete
join Beneficiaire b on se.identite = b.id


create or replace view ETUDIANTLIB as 
select e.id, e.nom, e.prenom, e.datenaissance, e.chemin, e.pere, tp.val as proffpere, e.mere, tp2.val as profmere, e.adresse,
e.contact, e.mail, s.val as sexe, ec.val as entite, e.niveau, p.val as pays, '' as promotion, '' as daty, '' as numero
FROM etudiant e,typeprof tp,beneficiaire ec,pays p,typeprof tp2,sexe s
WHERE e.proffpere=tp.id and e.profmere=tp2.id and e.entite=ec.id and e.pays=p.id and e.sexe=s.id 

CREATE OR REPLACE VIEW ConfPrixEtudiantLibelle AS SELECT conf.ID,
  conf.DATY,
  etu.NOM ||' '||etu.PRENOM AS ETUDIANT,
  conf.ECHEANCE,
  conf.ECOLAGE,
  conf.FOOD,
  conf.TRANSPORT,
  conf.INSCRIPTION,
  conf.AUTRES,
  conf.REMARQUES
FROM confprixetudiant conf
INNER JOIN etudiant etu
ON conf.ETUDIANT = etu.ID;

CREATE VIEW ConfPrixEtudiantLibelleHisto AS SELECT conf.ID,
  conf.DATY,
  etu.NOM ||' '||etu.PRENOM AS ETUDIANT,
  conf.ECHEANCE,
  conf.ECOLAGE,
  conf.FOOD,
  conf.TRANSPORT,
  conf.INSCRIPTION,
  conf.AUTRES,
  conf.REMARQUES
FROM confprixetudianthisto conf
INNER JOIN etudiant etu
ON conf.ETUDIANT = etu.ID;

CREATE VIEW ConfPrixEtudiantLibelleTotal AS SELECT conf.ID,
  conf.DATY,
  etu.NOM ||' '||etu.PRENOM AS ETUDIANT,
  conf.ECHEANCE,
  conf.ECOLAGE,
  conf.FOOD,
  conf.TRANSPORT,
  conf.INSCRIPTION,
  conf.AUTRES,
  (nvl(conf.ECOLAGE,0) + nvl(conf.FOOD,0) + nvl(conf.TRANSPORT,0) + nvl(conf.INSCRIPTION,0) + nvl(conf.AUTRES,0)) AS TOTAL,  
  conf.REMARQUES
FROM confprixetudiant conf
INNER JOIN etudiant etu
ON conf.ETUDIANT = etu.ID;