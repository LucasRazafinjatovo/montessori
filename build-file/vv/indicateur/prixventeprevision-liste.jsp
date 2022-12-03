<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
PrixVentePrevision p = new PrixVentePrevision();
p.setNomTable("PRIXVENTEPREVISION_LIBELLE");
String listeCrt[]={"id","journal","dateeffectivite","prix"};
String listeInt[]={"dateeffectivite", "prix"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("dateeffectivite1").setLibelle("Date d'effectivit&eacute; (min)");
pr.getFormu().getChamp("dateeffectivite2").setLibelle("Date d'effectivit&eacute; (max)");
pr.getFormu().getChamp("prix1").setLibelle("Prix de vente (min)");
pr.getFormu().getChamp("prix2").setLibelle("Prix de vente (max)");
pr.setApres("indicateur/prixventeprevision-liste.jsp");
String libEntete[]={"id","JOURNAL","DATEEFFECTIVITE","PRIX"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Prix de vente prévisionnel</h1>
<form action="<%=pr.getLien()%>?but=indicateur/prixventeprevision-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=indicateur/prixventeprevision-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id", "Journal", "Date d'effectivit&eacute;", "Prix de vente (Ar)"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>