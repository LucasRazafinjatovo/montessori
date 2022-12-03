<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Marge e=new Marge();

e.setNomTable("marge");

String listeCrt[]={"idMarge","valeur","daty"};
String listeInt[]=null;
String libEntete[]={"idMarge","valeur","daty"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeMarge.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste Marge</h1>
<form action="<%=pr.getLien()%>?but=activa/listeMarge.jsp" method="post" name="marge" id="marge">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichemarge.jsp"};
String colonneLien[]=null;
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>