<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Commande e=new Commande();

e.setNomTable("commande");

String listeCrt[]={"idcmd","iddevis","remarque","datecmd","dateLivraisonCmd"};
String listeInt[]=null;
String libEntete[]={"idcmd","iddevis","remarque","datecmd","dateLivraisonCmd"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listecommande.jsp");
pr.getFormu().getChamp("iddevis").setPageAppel("listeDemandeDevisChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des commandes</h1>
<form action="<%=pr.getLien()%>?but=activa/listecommande.jsp" method="post" name="commande" id="commande">
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