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
        SCatService scatsvc = null;
        String idScatService = null;
        String lien = null;
        String idService = null;
%>
<%
  idScatService = request.getParameter("idScatService");
  acte=request.getParameter("acte");
  lien=(String)session.getValue("lien");
        try
        {
           u=(UserEJB)session.getAttribute("u");
            scatsvc = u.findSCatService(idScatService,"%","%","%")[0];
          if (acte.compareTo("UPDATE")==0)
          {

//            u.updateSCatService(idService,scatsvc.getNomSCatService(),scatsvc.getIdCategorie(),String.valueOf(scatsvc.getPeriodeFacturation()));
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeService.jsp"); </script>
                  <%
           }
          if (acte.compareTo("INSERT")==0)
          {
//             u.createSCatService(request.getParameter("designation"), request.getParameter("idCat"), request.getParameter("periodeFact"));
           %>
         <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeSscatService.jsp"); </script>
         <%
          }
          if (acte.compareTo("DELETE")==0)
          {
            u.deleteSCatService(request.getParameter("idScatService"));
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeSscatService.jsp"); </script>
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
