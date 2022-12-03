<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
OffreJournal p = new OffreJournal();
p.setNomTable("OFFRE_JOURNAL_LIBELLE");
String listeCrt[]={"id","idoffre", "idjournal","montant"};
String listeInt[]={"montant"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("montant1").setLibelleAffiche("Montant (min)");
pr.getFormu().getChamp("montant2").setLibelleAffiche("Montant (max)");
pr.setApres("ventegazety/offreJournal-liste.jsp");
String libEntete[]={"id","idoffre", "idjournal","montant"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);%>
<h1>Liste des offres journaux</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/offreJournal-liste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/offreJournal-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"id","offre", "journal","montant"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>