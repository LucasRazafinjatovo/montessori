<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
ImpressionPrevision p = new ImpressionPrevision();
p.setNomTable("IMPRESSIONPREVISION_LIBELLE");
String listeCrt[]={"id","moisprod","nbimpression"};
String listeInt[]={"nbimpression"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("moisprod").setPageAppel("indicateur/choixMoisproduction.jsp");
pr.getFormu().getChamp("moisprod").setLibelle("Mois de production");

pr.getFormu().getChamp("nbimpression1").setLibelle("Nombre d'impression (min)");
pr.getFormu().getChamp("nbimpression2").setLibelle("Nombre d'impression (max)");

pr.setApres("indicateur/impressionprevision-liste.jsp");
String libEntete[]={"id", "MOISPROD","NBIMPRESSION"};

String colSomme[]={"NBIMPRESSION"};
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Nombre d'impression prévisionnel</h1>
<form action="<%=pr.getLien()%>?but=indicateur/impressionprevision-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=indicateur/impressionprevision-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id", "Mois de production", "Nombre d'impression"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>