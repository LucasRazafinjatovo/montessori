<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien = null;
%>
<%

  acte=request.getParameter("acte");
  lien=(String)session.getValue("lien");
        try
        {
           u=(UserEJB)session.getAttribute("u");
           if (acte.compareTo("DELETE")==0)
         {
          // String mois, String annee, String montant
             //u.updateChiffreAffTac(request.getParameter("idChiffre"),request.getParameter("mois"),request.getParameter("annee"),request.getParameter("montant"));
             u.annulerChiffreAffTac(request.getParameter("idChiffre"));

          %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=parametre/listeChiffreAffaireTac.jsp"); </script>
        <%
          }
          if (acte.compareTo("INSERT")==0)
          {
           // String mois, String annee, String montant
          u.createChiffreAffTac(request.getParameter("mois"),request.getParameter("annee"),request.getParameter("montant"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=parametre/listeChiffreAffaireTac.jsp"); </script>
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
