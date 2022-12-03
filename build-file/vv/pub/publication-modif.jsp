<%-- 
    Document   : publication-modif
    Created on : 29 juin 2017, 14:24:48
    Author     : Alain
--%>
<%@page import="pub.Publication"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
%>
<%
    u = (UserEJB) session.getValue("u"); 
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Publication a = new Publication();
    a.setNomTable("publication");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("journal").setPageAppel("listeChoixJournal.jsp");
    pi.getFormu().getChamp("numParution").setPageAppel("listeChoixParution.jsp");
    pi.getFormu().getChamp("parametre").setPageAppel("pub/listeParametreChoix.jsp");
    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.preparerDataFormu();
%>
<%if (u.getUser().getLoginuser().compareToIgnoreCase("Max") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("jaona") == 0) {%>
<h1>Modifier publication</h1>
<form action="<%=(String) session.getValue("lien")%>?but=pub/apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="contordremission">
    <%
        out.println(pi.getFormu().getHtmlInsert());
    %>

    <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>

    <br><br> 
    <input name="acte" type="hidden" id="acte" value="update">
    <input name="bute" type="hidden" id="bute" value="pub/listePublication.jsp">
    <input name="classe" type="hidden" id="classe" value="pub.Publication">

</form>

<%}else{%>
<h1>D�sol�,vous n'avez pas l'autorisation d'acc�der � cette page</h1>
<%}%>