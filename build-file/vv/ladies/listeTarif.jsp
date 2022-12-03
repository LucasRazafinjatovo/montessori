<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ladies.*" %>

<%

TarifPub p=new TarifPub();
String listeCrt[] = {"id","val","montant","description","dateffective"};
String listeInt[] = null;
String libEntete[] = {"id","val","montant","description","dateffective"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ladies/listeTarif.jsp");


String colSomme[]=null;

pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste pub</h1>
<form action="<%=pr.getLien()%>?but=ladies/listeTarif.jsp" method="post" name="listerpub" id="listerpub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = null;
String colonneLien[] = null;
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
%>
<%

out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
