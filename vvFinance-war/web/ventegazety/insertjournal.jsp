<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
    PrixjournalLibelle pj = new PrixjournalLibelle();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>

<h1>Saisir journal</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

    <%
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input type="submit" name="Submit2" value="valider" class="submit">
    <input type="reset" name="Submit2" value="Annuler" class="submit">
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="ventegazety/insertjournal.jsp">
    <input name="classe" type="hidden" id="classe" value="ventegazety.PrixjournalLibelle">
</form>
