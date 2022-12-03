<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%
Typelcdepense pj=new Typelcdepense();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("etat").setDefaut("1");
pi.getFormu().getChamp("val").setLibelle("Libelle");
pi.getFormu().getChamp("desce").setLibelle("Remarque");
pi.preparerDataFormu();
%>

<h1>Saisir Type LC</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="lc/saisietypelcdepense.jsp">
 <input name="classe" type="hidden" id="classe" value="lc.Typelcdepense">
</form>
