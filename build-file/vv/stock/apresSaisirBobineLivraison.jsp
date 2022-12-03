<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>

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
  //String idFact, String resp, String da, String mot, String mont,String type
    u.creerDetailBobine(request.getParameter("numBob"),request.getParameter("poids"),request.getParameter("id"),"");
 //u.faireMvtStock(request.getParameter("designation"),"1",request.getParameter("valeur"),"0", "0",request.getParameter("valeur"),request.getParameter("tiers"), request.getParameter("magasin"),request.getParameter("unite"), request.getParameter("noteExplicative"));
//id=u.createAvoir(request.getParameter("numFact"),request.getParameter("responsable"),request.getParameter("date"),request.getParameter("motif"),request.getParameter("montant"),request.getParameter("type"));
  %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=stock/saisir_bobine.jsp&id=<%=request.getParameter("id")%>&urlRetour=<%=urlRetour%>");
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
