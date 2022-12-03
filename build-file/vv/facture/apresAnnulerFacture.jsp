<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        String numFact = null;
        facture.AutorisationAnnulation autoAnnul =  null;
        String idFactMere= null;
        facture.FactMere fm = null;

%>
<%
 idFactMere=request.getParameter("numFact");
%>
<%
 try
{

  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");

    %>
<script language="JavaScript">
document.location.replace("<%=lien%>?but=facture/annulerObjet.jsp");
</script>
<%
  u.annulationFacture(request.getParameter("numFact"));
 %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/autoAnnulationErreur.jsp&idFactMere=<%=idFactMere%>"); </script>
     <%

}
catch (Exception e){
                        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&client=<%=request.getParameter("client")%>&numFact=<%=numFact%>&message=<%=e.getMessage()%>"); </script>
          <%return;
            }
%>
 
