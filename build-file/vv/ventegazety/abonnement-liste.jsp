<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
AbonnementVue p = new AbonnementVue();
p.setNomTable("abonnement_vue");
String listeCrt[]={"id","civilite", "abonne", "datedebut", "datefin", "telephone", "adresse"};
String listeInt[]={"datedebut", "datefin"};
String listeEntete[]={"id", "civilite", "abonne", "telephone", "adresse", "datedebut", "datefin", "observation", "etat"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,listeEntete,9);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("datedebut1").setLibelle("Date debut (min)");
pr.getFormu().getChamp("datedebut2").setLibelle("Date debut (max)");
pr.getFormu().getChamp("datefin1").setLibelle("Date fin (min)");
pr.getFormu().getChamp("datefin2").setLibelle("Date fin (max)");

pr.setApres("ventegazety/abonnement-liste.jsp");

String colSomme[]=null;
pr.creerObjetPage(listeEntete, colSomme);%>
<h1>Liste abonnement</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/abonnement-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/abonnement-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id", "Civilite", "Abonn&eacute;e", "Telephone", "Adresse", "Debut", "Fin", "Observation", "Etat"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>