<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien=null;
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
  if (acte.compareToIgnoreCase("ANNULE")==0)
  {
    u.annulationAvoir(request.getParameter("idAvoir"));
  %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=facture/listeAvoir.jsp");
</script>
<%}
  if (acte.compareToIgnoreCase("INSERT")==0)
  {
  //String idFact, String resp, String da, String mot, String mont,String type
System.out.println("NETY");
id=u.createAvoir(request.getParameter("numFact"),request.getParameter("responsable"),request.getParameter("date"),request.getParameter("motif"),request.getParameter("montant"),request.getParameter("type"));
  %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=facture/detailAvoir.jsp&idAvoir=<%=id%>");
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
