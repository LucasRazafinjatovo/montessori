<%-- 
    Document   : soustypecontact-modif
    Created on : Jan 26, 2018, 11:14:59 AM
    Author     : Tian
--%>
<%@page import="user.*"%>
<%@page import="bean.*" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    TypeObjet  typecontact = new TypeObjet();
    typecontact.setNomTable("SOUSTYPECONTACT");
    PageUpdate pi = new PageUpdate(typecontact, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("val").setLibelle("Valeur");  
    
    affichage.Champ[] liste=new affichage.Champ[1];
    
    TypeObjet act=new TypeObjet();
    act.setNomTable("typecontact");
    liste[0]=new Liste("desce",act,"val","id");
    
    pi.getFormu().changerEnChamp(liste);    
    pi.getFormu().getChamp("desce").setLibelle("Type Contact");
    pi.setLien((String) session.getValue("lien"));    
%>
<div class="content-wrapper">
    <h1>Modification sous type contact</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=admin/apresTarifTypeObjet.jsp" method="post" name="societe" id="societe">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="update">
    <input name="bute" type="hidden" id="bute" value="admin/soustype-contact-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
    <input name="nomtable" type="hidden" id="classe" value="soustypecontact">
    </form>
</div>
