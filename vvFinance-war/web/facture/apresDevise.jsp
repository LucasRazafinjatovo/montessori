<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String type = null;
        String desc = null;
        String lien = null;
%>

<%
        acte=request.getParameter("acte");
%>
<%

        try
        {
        lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
            u.updateTypeObjet("Devise",request.getParameter("idDevise"),request.getParameter("designation"),request.getParameter("description"));
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeDevise.jsp"); </script>
<%
           }
          if (acte.compareTo("INSERT")==0)
          {
            u.createTypeObjet("Devise","-",request.getParameter("idDevise"),request.getParameter("designation"),request.getParameter("description"));
%>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeDevise.jsp"); </script>
<%
          }
          if (acte.compareTo("DELETE")==0)
          {
              u.annulerDevise(request.getParameter("idDevise"));
%>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeDevise.jsp"); </script>
<%
          }
        }
        catch (Exception e)
        {
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%return;
        }
%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

</html>
