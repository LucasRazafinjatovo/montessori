<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String type = null;
        String desc = null;
        Service svc = null;
        String idService = null;
        String lien = null;
%>

<%
  idService = request.getParameter("idService");
  acte=request.getParameter("acte");
%>
<%
        try
        {
         lien=(String)session.getValue("lien");
         u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
           // String idService, String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient
           u.createService(request.getParameter("idSsCat"),request.getParameter("dateDebutValide"),request.getParameter("idUnite"),request.getParameter("designation"),request.getParameter("pu"),request.getParameter("idDevise"),request.getParameter("valeurTva"),request.getParameter("idClient"));
           %>
		  <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeService.jsp"); </script>
		  <%
           }
          if (acte.compareTo("INSERT")==0)
          {
          //  u.createService(request.getParameter("idSsCat"),request.getParameter("idUnite"),request.getParameter("designation"),request.getParameter("pu"),request.getParameter("idDevise"),request.getParameter("tva"),request.getParameter("idClient"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeService.jsp"); </script>
         <%
          }
          if (acte.compareTo("DELETE")==0)
          {
            u.deleteService(request.getParameter("idService"));
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeService.jsp"); </script>
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
