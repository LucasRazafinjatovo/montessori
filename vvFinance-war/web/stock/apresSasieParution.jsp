<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="stock.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien="modele.jsp";
        String id=null;
%>
<%
  acte=request.getParameter("acte");
%>
<%
try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");

  if (acte.compareToIgnoreCase("INSERT")==0)
  {
     id= u.faireMvtStock(request.getParameter("designation"),"4",request.getParameter("valeur"),"0", "0",request.getParameter("valeur"),request.getParameter("printer"), request.getParameter("journal"),request.getParameter("unite"), request.getParameter("noteExplicative"));
u.creerParution(request.getParameter("journal"),request.getParameter("numParution"),request.getParameter("dateParution"),request.getParameter("nbrPage"),request.getParameter("nbrExemplaire"),request.getParameter("poidsFeuille"), request.getParameter("printer"),id,request.getParameter("remarque"),"");
    %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=stock/liste_parution.jsp");
</script>
<%}
}
catch (Exception e){
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
