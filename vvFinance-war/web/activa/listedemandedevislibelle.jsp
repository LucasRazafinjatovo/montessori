<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevisLibelle e=new DemandeDevisLibelle();
e.setNomTable("demandedevisarticleprix1");
String listeCrt[]={"idDevis","nomclient","coderv","article","designation","nombreimpression","margeBenefice","remise","dateDevis"};
String listeInt[]=null;
String libEntete[]={"idDevis","nomclient","coderv","article","designation","nombreimpression","margeBenefice","remise","dateDevis"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listedemandedevislibelle.jsp");
pr.getFormu().getChamp("article").setPageAppel("listeArticleLibelleChoix.jsp");
pr.getFormu().getChamp("nomclient").setPageAppel("listeClientDemandeDevisChoix.jsp");
//pr.preparerDataFormu();
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des demandes devis non valide</h1>
<form action="<%=pr.getLien()%>?but=activa/listedemandedevislibelle.jsp" method="post" name="demandedevislibelle" id="demandedevislibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichedemandedevis.jsp"};
String colonneLien[]={"idDevis"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

