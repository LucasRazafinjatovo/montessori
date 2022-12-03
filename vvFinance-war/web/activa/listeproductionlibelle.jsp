<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
ProductionLibelle e=new ProductionLibelle();

e.setNomTable("productionlibelle");

String listeCrt[]={"idProduction","nomclient","coderv","article","designation","nombreimpression","dateDevis","debutCompteur","finCompteur"};
String listeInt[]=null;
String libEntete[]={"idProduction","nomclient","debutCompteur","finCompteur"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeproductionlibelle.jsp");
pr.getFormu().getChamp("nomclient").setPageAppel("listeClientProductionChoix.jsp");
pr.getFormu().getChamp("article").setPageAppel("listeArticleProductionChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des productions</h1>
<form action="<%=pr.getLien()%>?but=activa/listeproductionlibelle.jsp" method="post" name="productionlibelle" id="productionlibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/ficheproduction.jsp"};
String colonneLien[]={"idProduction"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

