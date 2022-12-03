<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Offre p = new Offre();
String listeCrt[]={"id","dateeffectivite", "duree"};
String listeInt[]={"dateeffectivite","duree"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("dateeffectivite1").setLibelleAffiche("Date effectivite (min)");
pr.getFormu().getChamp("dateeffectivite2").setLibelleAffiche("Date effectivite (max)");
pr.getFormu().getChamp("duree1").setLibelleAffiche("Duree (min)");
pr.getFormu().getChamp("duree2").setLibelleAffiche("Duree (max)");
pr.setApres("ventegazety/offre-liste.jsp");
String libEntete[]={"id","dateeffectivite", "duree"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des offres</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/offre-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/offre-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id","date effectivite", "duree"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>