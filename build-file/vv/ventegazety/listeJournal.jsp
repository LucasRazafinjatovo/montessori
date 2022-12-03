<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
PrixjournalLibelle jr=new PrixjournalLibelle();
jr.setNomTable("prixjournallibelle");
String listeCrt[]={"journal","nom","prix"};
String listeInt[]={""};
PageRecherche pr=new PageRecherche(jr,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeJournal.jsp");
String libEntete[]={"id","journal","nom","prix"};
String colSomme[]=null;
pr.setNpp(100);
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>

<h1>Liste des Journaux</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeJournal.jsp" method="post" name="listeJournal" id="listeJournal">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheJournal.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
