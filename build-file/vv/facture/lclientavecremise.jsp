<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facture.*" %>


<%
Clientavecremis e = new Clientavecremis();
e.setNomTable("Clientavecremiselettre");

String listeCrt[] = {"id","idClient","client","etat"};
String listeInt[] = null;
String libEntete[] = {"id","idClient","client","etat"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facture/lclientavecremise.jsp");

pr.getFormu().getChamp("id").setLibelle("idClient");
pr.getFormu().getChamp("idClient").setLibelle("ID Client");
pr.getFormu().getChamp("client").setLibelle("Client");

String[]colSomme = null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des bobines restant</h1>
<form action="<%=pr.getLien()%>?but=facture/lclientavecremise.jsp" method="post" name="article" id="article">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=facture/lclientavecremise.jsp"};
String colonneLien[] = null;
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form action="<%=pr.getLien()%>?but=pub/apresTarif.jsp" method="post" name="bobine" id="bobine">
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
 <input name="acte" type="hidden" id="nature" value="ventebobinot">
 <input name="bute" type="hidden" id="bute" value="facture/lclientavecremise.jsp">
 <input name="classe" type="hidden" id="classe" value="facture.Clientavecremis">
</form>