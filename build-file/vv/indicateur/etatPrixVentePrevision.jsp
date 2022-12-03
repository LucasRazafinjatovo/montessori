<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
EtatPrixVente p = new EtatPrixVente();
p.setNomTable("montantventeprevision_libelle");
String listeCrt[]={"journal","annee","mois","prixventeprevision"};
String listeInt[]={"annee", "prixventeprevision"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
pr.getFormu().getChamp("prixventeprevision1").setLibelle("Montant de vente (min)");
pr.getFormu().getChamp("prixventeprevision2").setLibelle("Montant de vente (min)");
pr.setApres("indicateur/etatPrixVentePrevision.jsp");
String libEntete[]={"Journal","annee","Mois","prixventeprevision"};

String colSomme[]={"prixventeprevision"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Etat : Montant de vente pr&eacute;visionnel</h1>
<form action="<%=pr.getLien()%>?but=indicateur/etatPrixVentePrevision.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String libEnteteAffiche[] = {"Journal", "Ann&eacute;e", "Mois", "Montant de vente previsionnel"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>