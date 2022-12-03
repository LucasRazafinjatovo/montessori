<%-- 
    Document   : detailClientApj
    Created on : 22 janv. 2018, 15:21:15
    Author     : herinihaja
--%>
<%@page import="user.*" %>
<%@page import="facture.*" %>
<%@page import="utilitaire.*" %>
<%@page import="bean.*" %>
<%@page import="affichage.*" %>
<%
    try {
        String idClient = request.getParameter("idClient");
        Client client = new Client();
        client.setNomTable("client_contact");
        PageConsulte pc = new PageConsulte(client, request, (user.UserEJB) session.getValue("u"));
        pc.setLien((String) session.getValue("lien"));
        pc.setTitre("Détail conçernant le client");
        
        TypeObjet phone = new TypeObjet();
        phone.setNomTable("TELEPHONE");
        TypeObjet[] listeTelephone = (TypeObjet[]) CGenUtil.rechercher(phone, null, null, " and val='" + idClient + "'");
        Client base = (Client) pc.getBase();    
%>
<div class="content-wraper">
    <h1>D&eacute;tail concernant le client <%=base.getNom()%></h1>
    <%        
        out.println(pc.getHtml());
    %>
    <h1>Liste telephone</h1>
    <table width="60%" cellpadding="0" align="center">
        <tr>
            <td>
                <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
                    <!--DWLayoutTable-->
                    <% if(listeTelephone!=null && listeTelephone.length>0 ){%>
                    <% for(int i=0;i<listeTelephone.length;i++){%>
                    <tr>
                        <td width="244" align="center"><%=listeTelephone[i].getDesce()%></td>
                    </tr>
                    <% } %>
                    <% } %>


                </table >
            </td>
        </tr>
    </table>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box" style="margin-top:0px !important;">
                    <div class="box-footer">
                        <a href="<%=(String) session.getValue("lien")%>?idClient=<%=base.getIdClient()%>&but=facture/updateClient.jsp">Modifier
                            le client&nbsp;</a>
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