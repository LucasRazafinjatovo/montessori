ALTER TABLE rubriqueprixentite ADD daty date;

create table rubriqueprixentitehisto(
	id character varying(100) PRIMARY KEY NOT NULL,
	libelle character varying(150),
	montant double precision,
	entite character varying(150),
	daty date
);

CREATE SEQUENCE SEQ_RubriquePrixEntite START WITH 1 INCREMENT BY 1;

create table type(
	id character varying(100) PRIMARY KEY NOT NULL,
	val character varying(150),
	desce character varying(150)
);
insert into type values ('1','0','sortie');
insert into type values ('2','1','entrée');

ALTER TABLE etudiant ADD etat character varying(50);




etudiant etat extends classEtat
1 default

1 entree 0 sortie 


exit etat => 0
insert mouvementEtudiant
