<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ladies.*" %>


<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ladies.*" %>

<%

Publicity p = new Publicity();
p.setNomTable("publicitylibelle");
String listeCrt[] = {"idClient","format","idCat","idAgence","datyparution","numPage","numBc","numPiece"};
String listeInt[] = null;
String libEntete[] = {"format","designation","montant","idCat","idAgence","numPage","numBc","remarque"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ladies/listePub.jsp");


String colSomme[]={"montant"};

pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste pub</h1>
<form action="<%=pr.getLien()%>?but=ladies/listePub.jsp" method="post" name="listerpub" id="listerpub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = null;
String colonneLien[] = null;
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<%

out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>



