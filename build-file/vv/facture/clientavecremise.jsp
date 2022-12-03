<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facture.*" %>


<%
Clientavecremis e = new Clientavecremis();
e.setNomTable("Clientavecremise");

PageInsert pi = new PageInsert(e,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("datedebut").setLibelle("Date");
pi.getFormu().getChamp("datedebut").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("idClient").setLibelle("Client");
pi.getFormu().getChamp("idClient").setPageAppel("ded/choix_tiers.jsp");

pi.preparerDataFormu();

%>

<h1>Saisie cleint avec remise</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="facture/clientavecremise.jsp">
 <input name="classe" type="hidden" id="classe" value="facture.Clientavecremis">
</form>