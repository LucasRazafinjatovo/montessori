<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String idTypeFacture=null;
        String lien=null;
        String date= null;
	String dateDebut = null;
        String idClient = null;
        String idFact = null;
        String idPen = null;
        historique.MapUtilisateur ut=null;
        penalite.Penalite pen = null;
%>
<%
idTypeFacture = request.getParameter("idType");
idPen = request.getParameter("idPen");
%>
<%
 	lien=(String)session.getValue("lien");

	try
	{
          u=(UserEJB)session.getAttribute("u");
          ut=u.getUser();
          pen=u.findPenaliteNonFacture(idPen,"","%","%","%","%","%","%","%")[0];
           if(request.getParameter("idPen").compareTo(idPen)==0){
                idFact = u.createFacturePenalite(idPen);

      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {

             %>
<script language="JavaScript">

                 document.location.replace("<%=lien%>?but=facture/factureFilleRedAdmin.jsp&idFactMere=<%=idFact%>&action=red&refObj=<%=pen.getIdPenalite()%>");
                 </script>
<%
                }else{
%>
<script language="JavaScript">

                 document.location.replace("<%=lien%>?but=facture/factureFilleRed.jsp&idFactMere=<%=idFact%>&action=red");
                 </script>
<%
                 }
          }
        }catch (Exception e){
	 %>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
        return;
	}
	%>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

</html>
