<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>

<%
Echeancier p = new Echeancier();
p.setNomTable("echeancier_vue");
String listeCrt[]={"societe","exercice","compte", "comptetiers", "typetiers", "numerotiers", "daty", "codejournal", 
	"numpiece", "numero",  "echeance", "libelle"};
String listeInt[]={"daty", "numero", "echeance", "numerotiers"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[2];

TypeObjet tob = new TypeObjet();
tob.setNomTable("journalcompta");
liste[0]=new Liste("codejournal", tob, "desce", "desce");
Societe to1=new Societe();
liste[1]=new Liste("societe",to1,"nom","nom");
pr.getFormu().changerEnChamp(liste);

pr.getFormu().getChamp("compte").setPageAppel("comptabilite/choixCompte.jsp");
pr.getFormu().getChamp("comptetiers").setPageAppel("comptabilite/choixCompteTiers.jsp");
pr.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr.getFormu().getChamp("daty1").setLibelle("Date (min)");
pr.getFormu().getChamp("daty2").setLibelle("Date (max)");
pr.getFormu().getChamp("echeance1").setLibelle("Echeance (min)");
pr.getFormu().getChamp("echeance2").setLibelle("Echeance (max)");
pr.getFormu().getChamp("numero1").setLibelle("Numero (min)");
pr.getFormu().getChamp("numero2").setLibelle("Numero (max)");
pr.getFormu().getChamp("numerotiers1").setLibelle("Numero tiers (min)");
pr.getFormu().getChamp("numerotiers2").setLibelle("Numero tiers (max)");

pr.setApres("comptabilite/echeancier-etat.jsp");


String libEntete[]={"societe", "exercice", "codejournal","compte","comptetiers", "numero","daty","numpiece",
	"libelle", "echeance", "montantdebit", "montantcredit"};

String colSomme[]={"MONTANTDEBIT", "MONTANTCREDIT", "SOLDE"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Echeancier</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/echeancier-etat.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String libEnteteAffiche[] = {"Exercice", "Soci&eacute;t&eacute;", "Code journal", "Compte", "Compte tiers",  "N° ecriture", "Date", 
"N° piece",  "Libelle", "Echeance", "Montant debit", "Montant credit"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>