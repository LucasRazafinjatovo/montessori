<%-- 
    Document   : jourferie-modif
    Created on : 7 sept. 2016, 11:28:23
    Author     : Admin
--%>

<%@page import="affichage.PageUpdate"%>
<%@page import="pointage.PointJourferie"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        PointJourferie a = new PointJourferie();
        PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("daty").setLibelle("Date");
        //pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("designation").setLibelle("Designation");
        pi.getFormu().getChamp("designation").setType("textarea");
        pi.getFormu().getChamp("remarque").setVisible(true);
        pi.getFormu().getChamp("heure_debut").setLibelle("Heure debut");
        pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin");
       // pi.getFormu().getChamp("heure_debut").setAutre("placeholder='HH:MM:SS'");
       // pi.getFormu().getChamp("heure_fin").setAutre("placeholder='HH:MM:SS'");
        //pi.getFormu().getChamp("type").setAutre("placeholder='Champ obligatoire'");
        pi.preparerDataFormu();
%>
<html>
    <h1 align="center">Modification Jour F&eacute;rié</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="jourferie" id="jourferie" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="acte" value="update">
        <input name="bute" type="hidden" id="bute" value="pointage/jourferie-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="pointage.PointJourferie">
        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
        <input name="nomtable" type="hidden" id="nomtable" value="point_jourferie">
    </form>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
</html>