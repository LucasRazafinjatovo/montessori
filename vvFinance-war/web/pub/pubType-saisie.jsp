<%-- 
    Document   : pubType-saisie
    Created on : 9 mai 2017, 09:15:11
    Author     : Doudou Tiarilala
--%>

<%@page import="pub.PubType"%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageInsert"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PubType a = new PubType();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("DUREES").setLibelle("Durre (HH:MM:SS)");
    pi.getFormu().getChamp("DUREE").setVisible(false);
    pi.preparerDataFormu();
%>

<h1 align="center">Saisie type pub</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="mequipe" id="mequipe" autocomplete="off" data-parsley-validate>
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="pub/pubType-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="pub.PubType">
</form>

