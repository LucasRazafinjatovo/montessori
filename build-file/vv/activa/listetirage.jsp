<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Tirage e=new Tirage();

e.setNomTable("tirage");

String listeCrt[]={"idTirage","nbTirage","coutNombreTirage","typeCouleur"};
String listeInt[]=null;
String libEntete[]={"idTirage","nbTirage","coutNombreTirage","typeCouleur"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listetirage.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste Tirage</h1>
<form action="<%=pr.getLien()%>?but=activa/listetirage.jsp" method="post" name="tirage" id="tirage">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichetirage.jsp"};
String colonneLien[]={"idTirage"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>