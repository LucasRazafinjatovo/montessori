<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="ded.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String lien="modele.jsp";
        String typa="";
        String objet="";
%>
<%
  acte=request.getParameter("acte");
typa=request.getParameter("typa");
objet=request.getParameter("objet");
%>
<%

try
{

  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  if(acte.compareToIgnoreCase("INSERT")==0)
  	u.createAutorisationAnnulation(request.getParameter("num"),request.getParameter("responsable"),request.getParameter("date"),request.getParameter("motif"),request.getParameter("idTypeObjet"));
	if((acte.compareToIgnoreCase("valider")==0))
        {
          u.validerAutoAnnulation(request.getParameter("id"));
          if(typa.compareToIgnoreCase("ORR")==0||typa.compareToIgnoreCase("ORP")==0)
          {
            OrdonnerPayement.suprimerOp(objet);
          }
        }
%>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=facture/listeAutoAnnulation.jsp&idTypeObjet=<%=request.getParameter("idTypeObjet")%>");
</script>
<%
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
