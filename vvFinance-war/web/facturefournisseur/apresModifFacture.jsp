<%-- 
    Document   : apresModifFacture
    Created on : 29 janv. 2018, 10:27:12
    Author     : ando
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="affichage.Page"%>
<%@page import="bean.ClassMAPTable"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute = "facture/visualiserFactureClient.jsp";
    %>
    <%
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            String nombreFF = request.getParameter("nombreFF");
            String idfm = request.getParameter("id");            
            System.out.println("IDFM:"+idfm);
            int mes = Integer.parseInt(nombreFF);
            String[] idfactureFille = new String[mes];
            double[] prixUnitaire = new double[mes];
            double[] quantite = new double[mes];
            int[] reduction = new int[mes];
            for(int i = 0; i < mes; i++ ){
                idfactureFille[i] = request.getParameter("idfacturefille_"+i);
                prixUnitaire[i] =Double.parseDouble(request.getParameter("prixunitaire_"+i));
                quantite[i] = Double.parseDouble(request.getParameter("quantite_"+i));
                reduction[i] =  Integer.parseInt(request.getParameter("reduction_"+i));
            }  
            double tva = Double.parseDouble(request.getParameter("tva"));            
            String rajoutLien = "&idFactureFournisseur="+request.getParameter("id");
            u.modifierFacture(idfm, idfactureFille, prixUnitaire, quantite, reduction, tva);
            

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%><%=rajoutLien%>");</script>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back();</script>
    <%
            return;
        }
    %>
</html>
