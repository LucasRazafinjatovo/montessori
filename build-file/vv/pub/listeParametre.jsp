<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
ParametreBase p=new ParametreBase();
p.setNomTable("parametrepaier");
String listeCrt[]={"poids","dateEffectivite"};
String listeInt[]={"poids","dateEffectivite"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listeParametre.jsp");
String libEntete[]={"id","hauteur","largeur","poids","marge","dateEffectivite"};
String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des parametres</h1>
<form action="<%=pr.getLien()%>?but=pub/listeParametre.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
  String lienTableau[]={pr.getLien()+"?but=pub/ficheParametre.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
