<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
MoisProduction p = new MoisProduction();
p.setNomTable("MOISPRODUCTION_LIBELLE");
String listeCrt[]={"id", "journal","mois","annee","nbjrs"};
String listeInt[]={"mois","annee", "nbjrs"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("mois1").setLibelle("Mois (min)");
pr.getFormu().getChamp("mois2").setLibelle("Mois (max)");
pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
pr.getFormu().getChamp("nbjrs1").setLibelle("Nombre de jours (min)");
pr.getFormu().getChamp("nbjrs2").setLibelle("Nombre de jours (max)");
pr.setApres("indicateur/moisproduction-liste.jsp");
String libEntete[]={"id","JOURNAL", "MOIS","ANNEE","NBJRS"};

String colSomme[]={"NBJRS"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Mois de production</h1>
<form action="<%=pr.getLien()%>?but=indicateur/moisproduction-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=indicateur/moisproduction-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id","Journal", "Mois", "Ann&eacute;e", "Nombre de jours"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>