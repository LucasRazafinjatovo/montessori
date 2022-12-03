<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
	String apres = null;
        TypeObjet catserv = null;
        String idObjet = null;
        String idClient = null;
        facture.Client clt = null;
        String idTo = null;

%>
<%
  idClient = request.getParameter("idClient");
  acte=request.getParameter("acte");
%>
<%

        try
        {
	  lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
            catserv = u.findTypeObjet(idTo,"%","%")[0];
            u.updateTypeObjet(idObjet,"%","%","%");
           %>
  			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeCatService.jsp"); </script>
		  <%
           }
          if (acte.compareTo("INSERT")==0)
          {
            u.createTypeObjet("categorie","GetSeqCatService","cat",request.getParameter("designation"),request.getParameter("description"));
           %>
 			 <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeCatService.jsp"); </script>
 		 <%
          }
          if (acte.compareTo("DELETE")==0)
          {
            u.deleteTypeObjet("categorie",request.getParameter("idObjet"));
           %>
  		<script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/listeCatService.jsp"); </script>
  			<%
          }
        }catch (Exception e){
		%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
		return;
        }
		%>


<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
</html>
