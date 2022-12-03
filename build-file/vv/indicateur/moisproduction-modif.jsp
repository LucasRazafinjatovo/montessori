<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
MoisProduction atcl=new MoisProduction();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];

TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to, "desce", "id");

pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("id").setAutre("readonly='readonly'");
pi.getFormu().getChamp("mois").setDefaut("1");
pi.getFormu().getChamp("annee").setDefaut("2016");
pi.getFormu().getChamp("nbjrs").setDefaut("0");
pi.getFormu().getChamp("mois").setLibelle("Mois");
pi.getFormu().getChamp("annee").setLibelle("Année");
pi.getFormu().getChamp("journal").setLibelle("Journal");
pi.getFormu().getChamp("nbjrs").setLibelle("Nombre de jours ouvrables");

pi.preparerDataFormu();
%>

<h1>Modification mois de production</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="indicateur/moisproduction-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="indicateur.MoisProduction">
</form>
