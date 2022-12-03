<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
 
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        String numFact = null;
        AutorisationAnnulation autoAnnul = null;
        String idFactMere= null;
        FactMere fm = null;

%>
<%
idFactMere=request.getParameter("numFact");
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
try{
fm=u.findFactureMere("%","%",idFactMere,"%","%","%","%","%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<p class="remarque">Il n'existe aucune autorisation d'annulation pour la facture
  N&deg; <%=request.getParameter("idFactMere")%>. Veuillez
  v&eacute;rifiez votre saisie, et entrez de nouveau le num&eacute;ro </p>

