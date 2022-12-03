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
 //faireMvtStock(String design, String type, String debitS, String creditS, String debitD, String creditD, String compteS, String compteD, String unite, String rmq)
id=u.faireMvtStock(request.getParameter("designation"),"2",request.getParameter("valeur"),"0", "0",request.getParameter("valeur"),request.getParameter("compteMag"), request.getParameter("compteTrs"),request.getParameter("unite"), request.getParameter("noteExplicative"));
LettrageMvt let=u.findLettrageMvt(id,"%","%")[0];
//id=u.createAvoir(request.getParameter("numFact"),request.getParameter("responsable"),request.getParameter("date"),request.getParameter("motif"),request.getParameter("montant"),request.getParameter("type"));
  %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=stock/confirmation_mouvement_emprunt.jsp&id=<%=let.getParent()%>");
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
