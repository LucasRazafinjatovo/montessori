<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
CommandeLibelle e=new CommandeLibelle();
e.setNomTable("commandelibelle");
String listeCrt[]={"idcmd","nomclient","coderv","article","designation","nombreimpression","remise","dateDevis","remarque","datecmd","datelivraisoncmd"};
String listeInt[]=null;
String libEntete[]={"idcmd","nomclient","article","datecmd","datelivraisoncmd"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeproductionlibelle.jsp");
pr.getFormu().getChamp("nomclient").setPageAppel("listeClientCommandeChoix.jsp");
pr.getFormu().getChamp("article").setPageAppel("listeArticleCommandeChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste commandes</h1>
<form action="<%=pr.getLien()%>?but=activa/listecommandelibelle.jsp" method="post" name="commandelibelle" id="commandelibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichecommande.jsp"};
String colonneLien[]={"idcmd"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

