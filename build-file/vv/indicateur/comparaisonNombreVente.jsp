<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
ComparaisonNombreVente p = new ComparaisonNombreVente();
p.setNomTable("comparaisonombrevente_libelle");
String listeCrt[]={"journal","annee","mois", "venteprev", "vente", "diffvente"};
String listeInt[]={"annee", "venteprev", "vente", "diffvente"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
pr.getFormu().getChamp("venteprev1").setLibelle("Nombre de vente prevu (min)");
pr.getFormu().getChamp("venteprev2").setLibelle("Nombre de vente prevu (max)");
pr.getFormu().getChamp("vente1").setLibelle("Nombre de vente (min)");
pr.getFormu().getChamp("vente2").setLibelle("Nombre de vente (max)");
pr.getFormu().getChamp("diffvente1").setLibelle("Difference vente (min)");
pr.getFormu().getChamp("diffvente2").setLibelle("Difference vente (max)");
pr.setApres("indicateur/comparaisonNombreVente.jsp");
String libEntete[]={"Journal","annee","Mois", "venteprev", "vente", "diffvente"};

String colSomme[]={ "venteprev", "vente", "diffvente"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Analyse : comparaison nombre de vente</h1>
<form action="<%=pr.getLien()%>?but=indicateur/comparaisonNombreVente.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String libEnteteAffiche[] = {"Journal", "Ann&eacute;e", "Mois", 
	"Nombre de vente prevu", "Nombre de vente", "Difference de vente"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>