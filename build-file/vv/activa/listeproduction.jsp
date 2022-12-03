<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Production e=new Production();

e.setNomTable("production");

String listeCrt[]={"idProduction","idcmd","debutCompteur","finCompteur"};
String listeInt[]=null;
String libEntete[]={"idProduction","idcmd","debutCompteur","finCompteur"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeproduction.jsp");

affichage.Champ[] liste=new affichage.Champ[1];

Commande c=new Commande();
c.setNomTable("commande");
liste[0]=new Liste("idcmd",c,"remarque","idcmd");
pr.getFormu().changerEnChamp(liste);
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des productions</h1>
<form action="<%=pr.getLien()%>?but=activa/listeproduction.jsp" method="post" name="production" id="production">
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

