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
        String idParent=null;
        String retourPage = null;
%>
<%
  acte=request.getParameter("acte");
idParent=request.getParameter("id");
%>
<%
try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
retourPage = request.getParameter("retourPage");
  if (acte.compareToIgnoreCase("INSERT")==0)
  {
      id=u.faireMvtStock(request.getParameter("designation"),"5","0",request.getParameter("valeur"), request.getParameter("valeur"),"0",Constantes.compteTransitEmpruntReception,request.getParameter("compteMag"),request.getParameter("unite"), request.getParameter("noteExplicative"));
u.creerLettrageMvt(idParent,id,"lettrage manuel reception magasin","");
  %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=stock/magasin_dest_entrepot.jsp&id=<%=idParent%>");
</script>
<%}

  if (acte.compareToIgnoreCase("DELETE")==0)
  {
 String id = request.getParameter("id");
  String idDossier = request.getParameter("idDossier");
 u.enleverDossier(idDossier);
 %>
<script language="JavaScript">
  document.location.replace("<%=lien%>?but=stock/dossier_mouvement.jsp&id=<%=id%>");
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
