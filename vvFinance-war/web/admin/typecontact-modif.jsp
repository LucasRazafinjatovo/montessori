<%-- 
    Document   : typecontact-modif
    Created on : Jan 26, 2018, 11:11:13 AM
    Author     : Tian
--%>
<%@page import="user.*"%>
<%@page import="bean.*" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    TypeObjet  typecontact = new TypeObjet();
    typecontact.setNomTable("TYPECONTACT");
    PageUpdate pi = new PageUpdate(typecontact, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("val").setLibelle("Valeur");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.setLien((String) session.getValue("lien"));    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Modification type contact</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=admin/apresTarifTypeObjet.jsp" method="post" name="societe" id="societe">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="update">
    <input name="bute" type="hidden" id="bute" value="admin/type-contact-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
    <input name="nomtable" type="hidden" id="classe" value="typecontact">
    </form>
</div>