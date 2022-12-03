<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        Tva tva = null;
        String idService = null;
        String lien = null;
%>
<%
  idService = request.getParameter("idService");
  acte=request.getParameter("acte");
  lien=(String)session.getValue("lien");
        try
        {
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("INSERT")==0)
          {
           u.createTva(request.getParameter("valeur"),request.getParameter("dateDebut"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeTva.jsp"); </script>
         <%
          }
        }
        catch (Exception e)
        {%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%return;
        }
%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

</html>
