<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Livraison e=new Livraison();
e.setNomTable("livraison");
String listeCrt[]={"idLivraison","idProduction","quantite","heureLivraison","dateLivraison"};
String listeInt[]=null;
String libEntete[]={"idLivraison","idProduction","quantite","heureLivraison","dateLivraison"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,5);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listelivraison.jsp");

affichage.Champ[] liste=new affichage.Champ[1];
Livraison c=new Livraison();
c.setNomTable("livraison");
liste[0]=new Liste("idProduction",c,"idproduction","idproduction");
pr.getFormu().changerEnChamp(liste);
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des livraisons</h1>
<form action="<%=pr.getLien()%>?but=activa/listeproduction.jsp" method="post" name="production" id="production">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/listeproduction.jsp"};
String colonneLien[]={"idProduction"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

