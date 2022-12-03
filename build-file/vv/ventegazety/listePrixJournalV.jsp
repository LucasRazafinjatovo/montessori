<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Prixjournalvendeur rv=new Prixjournalvendeur();
rv.setNomTable("PRIXJOURNALVENDEURLIBELLE");
String listeCrt[]={"vendeur","matricule","journal","dateeffective"};
String listeInt[]={"dateeffective"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listePrixJournalV.jsp");
String libEntete[]={"id","vendeur","matricule","journal","prix","dateeffective"};
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"prix"};

pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Liste des prix individuelles</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listePrixJournalV.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
  String lienTableau[]={pr.getLien()+"?but=ventegazety/modifPrixjournalVendeur.jsp"};
  String colonneLien[]={"id"};
  pr.getTableau().setLien(lienTableau);
  pr.getTableau().setColonneLien(colonneLien);

out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
