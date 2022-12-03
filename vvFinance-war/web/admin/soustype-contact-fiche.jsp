<%-- 
    Document   : soutype-contact-fiche
    Created on : 26 janv. 2018, 09:41:20
    Author     : herinihaja
--%>


<%@page import="user.*" %>
<%@page import="facture.*" %>
<%@page import="utilitaire.*" %>
<%@page import="bean.*" %>
<%@page import="affichage.*" %>
<%
    try {
        TypeObjet typeC = new TypeObjet();
        typeC.setNomTable("SOUSTYPECONTACTLIBELLE");
        PageConsulte pc = new PageConsulte(typeC, request, (user.UserEJB) session.getValue("u"));
        pc.setLien((String) session.getValue("lien"));
        pc.setTitre("SousType contact fiche");
        TypeObjet base = (TypeObjet) pc.getBase();    
%>
<div class="content-wraper">
    <h1>SousType contact fiche </h1>
    <%        
        out.println(pc.getHtml());
    %>
    
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box" style="margin-top:0px !important;">
                    <div class="box-footer">
                        <a href="<%=(String) session.getValue("lien")%>?id=<%=base.getId()%>&but=admin/soustypecontact-modif.jsp">Modifier</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<% } catch (Exception ex) {
        ex.printStackTrace();
        throw new Exception(ex.getMessage());
    }
%>

<script>
    $(document).ready(function () {
        $(".box").css("margin-top", "100px");
        $(".box-title.with-border").css("margin-top", "0px");
    })
</script>   