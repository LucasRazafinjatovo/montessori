<%-- 
    Document   : pubType-modif
    Created on : 9 mai 2017, 09:45:19
    Author     : Doudou Tiarilala
--%>

<%@page import="pub.PubType"%> 
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    PubType a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new PubType();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));  
    pi.getFormu().getChamp("DUREES").setLibelle("DUREES(HH:MM:SS)");   
    pi.getFormu().getChamp("duree").setVisible(false); 
    pi.preparerDataFormu();
%>

<h1>Modification d'un type pub</h1>
<form action="<%=(String) session.getValue("lien")%>?but=pub/apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="contordremission">
    <%
        out.println(pi.getFormu().getHtmlInsert());
    %>

    <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>

    <br><br> 

    <input name="acte" type="hidden" id="acte" value="update">
    <input name="bute" type="hidden" id="bute" value="pub/pubType-fiche.jsp">

    <input name="classe" type="hidden" id="classe" value="pub.PubType">
    <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >

</form>
