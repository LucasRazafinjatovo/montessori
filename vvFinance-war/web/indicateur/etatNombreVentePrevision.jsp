<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
EtatNombreVente p = new EtatNombreVente();
p.setNomTable("nbventeprevision_libelle");
String listeCrt[]={"journal","annee","mois","nombreventeprevisionnel","nombreimpression"};
String listeInt[]={"annee", "nombreventeprevisionnel","nombreimpression"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e (min)");
pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e (max)");
pr.getFormu().getChamp("nombreventeprevisionnel1").setLibelle("Nombre de vente (min)");
pr.getFormu().getChamp("nombreventeprevisionnel2").setLibelle("Nombre de vente (max)");
pr.getFormu().getChamp("nombreimpression1").setLibelle("Nombre d'impression (min)");
pr.getFormu().getChamp("nombreimpression2").setLibelle("Nombre d'impression (max)");
pr.setApres("indicateur/etatNombreVentePrevision.jsp");
String libEntete[]={"Journal","annee","Mois","nombreventeprevisionnel", "nombreimpression"};

String colSomme[]={"nombreventeprevisionnel", "nombreimpression"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Etat : nombre de vente pr&eacute;visionnel</h1>
<form action="<%=pr.getLien()%>?but=indicateur/etatNombreVentePrevision.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String libEnteteAffiche[] = {"Journal", "Ann&eacute;e", "Mois", "Nombre de vente prevu", "Nombre d'impression prevu"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>