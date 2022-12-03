<%-- 
    Document   : jourferie-saisie
    Created on : 11 dï¿½c. 2015, 09:23:13
    Author     : user
--%>
<%@page import="pointage.PointJourferie"%> 
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%
    try {
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PointJourferie a = new PointJourferie();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("designation").setType("textarea");
    pi.getFormu().getChamp("remarque").setVisible(false);
	pi.getFormu().getChamp("type").setVisible(false);
    pi.getFormu().getChamp("heure_debut").setLibelle("Heure debut");
    pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin");
    pi.getFormu().getChamp("heure_debut").setAutre("placeholder='HH:MM:SS'");
    pi.getFormu().getChamp("heure_fin").setAutre("placeholder='HH:MM:SS'");
    pi.getFormu().getChamp("type").setAutre("placeholder='Champ obligatoire'");
    pi.preparerDataFormu();
%>
<html>
    <h1 align="center">Jour F&eacute;rié</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="jourferie" id="jourferie" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="pointage/jourferie-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="pointage.PointJourferie">
    </form>
</html>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% } %>