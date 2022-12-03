<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
LivraisonLibelle e=new LivraisonLibelle();
e.setNomTable("livraisonlibelle");
String listeCrt[]={"idLivraison","nomclient","coderv","article","designation","nombreimpression","dateDevis","quantite","heureLivraison","dateLivraison"};
String listeInt[]=null;
String libEntete[]={"idLivraison","nomclient","designation","quantite","heureLivraison","dateLivraison"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listelivraisonlibelle.jsp");
pr.getFormu().getChamp("nomclient").setPageAppel("listeClientLivraisonChoix.jsp");
pr.getFormu().getChamp("article").setPageAppel("listeArticleLivraisonChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des livraisons</h1>
<form action="<%=pr.getLien()%>?but=activa/listelivraisonlibelle.jsp" method="post" name="livraisonlibelle" id="livraisonlibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichelivraison.jsp"};
String colonneLien[]={"idLivraison"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

