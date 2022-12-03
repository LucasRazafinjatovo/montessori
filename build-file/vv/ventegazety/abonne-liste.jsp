<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
AbonneComplet p = new AbonneComplet();
p.setNomTable("abonne_vue");
String listeCrt[]={"id","idcivilite", "nom","prenom", "cin", "telephone", "adresse", "idquartier","idsecteur"};
String listeInt[]=null;
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("idcivilite").setLibelle("Civilit&eacute;");
pr.getFormu().getChamp("idsecteur").setLibelle("Secteur");
pr.getFormu().getChamp("idquartier").setLibelle("Quartier");
pr.setApres("ventegazety/abonne-liste.jsp");
String libEntete[]={"id","idcivilite", "nom","prenom", "cin", "telephone", "adresse", "idquartier", "idsecteur"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des abonn&eacute;s</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/abonne-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/abonne-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id","Civilit&eacute;", "Nom", "Prenom", "CIN", "Telephone", "Adresse", "Quartier", "Secteur"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>