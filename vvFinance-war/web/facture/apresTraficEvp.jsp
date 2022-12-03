
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien = null;
%>
<%

  acte=request.getParameter("acte");
  lien=(String)session.getValue("lien");
        try
        {
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
System.out.println(request.getParameter("idTrafic")+request.getParameter("date")+request.getParameter("dateDebut")+request.getParameter("dateFin")+request.getParameter("nombre")+request.getParameter("remarque")+request.getParameter("idService"));
            //String idTrafic, String daty, String datyDebut, String datyFin, String nb, String rem, String idserv
            u.updateTrafic(request.getParameter("idTrafic"),request.getParameter("date"),request.getParameter("dateDebut"),request.getParameter("dateFin"),request.getParameter("nombre"),request.getParameter("remarque"),request.getParameter("idService"));

           %>
		  <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeTraficEvp.jsp"); </script>
		  <%
           }
          if (acte.compareTo("INSERT")==0)
          {
           // tring daty, String datyDebut, String datyFin, String nb, String rem, String idserv
            u.createTrafic(request.getParameter("date"),request.getParameter("dateDebut"),request.getParameter("dateFin"),request.getParameter("nombre"),request.getParameter("remarque"),request.getParameter("idService"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeTraficEvp.jsp"); </script>
         <%
          }
          if (acte.compareTo("ANNULE")==0)
          {
            u.annulerTrafic(request.getParameter("idTrafic"));
            //u.deleteService(request.getParameter("idService"));
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeTraficEvp.jsp"); </script>
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
