<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
ArticleLibelle a=new ArticleLibelle();
a.setNomTable("articleavectype");
String listeCrt[]={"idArticle","libelle","typearticle","nombrerame","grs","format"};
String listeInt[]=null;
String libEntete[]={"idArticle","libelle","typearticle","nombrerame","grs","format"};
PageRecherche pr=new PageRecherche(a,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listearticlelibelle.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des papiers</h1>
<form action="<%=pr.getLien()%>?but=artiva/listearticlelibelle.jsp" method="post" name="articlelibelle" id="articlelibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichearticle.jsp"};
String colonneLien[]={"idArticle"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
//out.println(pr.getBasPage());
%>