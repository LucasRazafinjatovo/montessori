<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="exportation.Parametre" %>
<%
exportation.Parametre pj=new exportation.Parametre();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

/*pi.getFormu().getChamp("dateInf").setType("text");
pi.getFormu().getChamp("dateSup").setType("text");

pi.getFormu().getChamp("dateInf").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("dateSup").setDefaut(Utilitaire.dateDuJour());

pi.getFormu().getChamp("datyoperation").setVisible(false);*/
pi.preparerDataFormu();
%>

<h1>Saisir parametre export</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="exportation/parametre.jsp">
 <input name="classe" type="hidden" id="classe" value="exportation.Parametre">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
