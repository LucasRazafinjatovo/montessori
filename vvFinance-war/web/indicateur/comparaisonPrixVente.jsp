<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
ComparaisonPrixVente p = new ComparaisonPrixVente();
p.setNomTable("comparaisonprixvente_libelle");
String listeCrt[]={"journal","annee","mois", "prixventeprevision", "venteeffectif", "paiement", "impaye"};
String listeInt[]={"annee","prixventeprevision", "venteeffectif", "paiement", "impaye"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
pr.getFormu().getChamp("prixventeprevision1").setLibelle("Montant de vente prevu (min)");
pr.getFormu().getChamp("prixventeprevision2").setLibelle("Montant de vente prevu (max)");
pr.getFormu().getChamp("venteeffectif1").setLibelle("Montant de vente (min)");
pr.getFormu().getChamp("venteeffectif2").setLibelle("Montant de vente (max)");
pr.getFormu().getChamp("paiement1").setLibelle("Montant pay&eacute; (min)");
pr.getFormu().getChamp("paiement2").setLibelle("Montant pay&eacute; (max)");
pr.getFormu().getChamp("impaye1").setLibelle("Montant impay&eacute; (min)");
pr.getFormu().getChamp("impaye2").setLibelle("Montant impay&eacute; (max)");
pr.setApres("indicateur/comparaisonPrixVente.jsp");
String libEntete[]={"Journal","annee","Mois", "prixventeprevision", "venteeffectif", "paiement", "impaye"};

String colSomme[]={"prixventeprevision", "venteeffectif", "paiement", "impaye"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Analyse : comparaison prix de vente</h1>
<form action="<%=pr.getLien()%>?but=indicateur/comparaisonPrixVente.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String libEnteteAffiche[] = {"Journal", "Ann&eacute;e", "Mois",
	"Montant de vente prevu", "Montant de vente","Montant pay&eacute", "Montant impay&eacute"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>