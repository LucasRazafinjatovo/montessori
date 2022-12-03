<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree=null;
        String numFact=null;
        String typa=null;
	    String nomClient=null;
	    String idLigne = null;

%>
<%
acte=request.getParameter("acte");

	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("UPDATE")==0)
          {
          rep=u.updateEntree(request.getParameter("id"),request.getParameter("date"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("client"),request.getParameter("idType"),request.getParameter("numPiece"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),"cree",request.getParameter("remarque"),"-","-",idLigne);
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeEntree.jsp&daty1=<%=request.getParameter("daty")%>&daty2=<%=request.getParameter("daty")%>"); </script>
           <%
          }
          if (acte.compareTo("INSERT")==0)
          {
            u.createCheque(request.getParameter("idMvt"),request.getParameter("datyS"),request.getParameter("datyV"),request.getParameter("ordre"),request.getParameter("rem"),request.getParameter("numCheque"),request.getParameter("caisse"),request.getParameter("montant"));// request.getParameter("projet"), request.getParameter("partenaire"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/cheque.jsp"); </script>
          <%
          }
          if (acte.compareTo("VIRER")==0)
          {                          //String daty,          String caisse1,                      String caisse2,                   String montant,    String remarque, String devise, String mode
            u.virer(request.getParameter("daty"),request.getParameter("caisse1"),request.getParameter("caisse2"),request.getParameter("montant"),request.getParameter("remarque"),request.getParameter("idDevise"),request.getParameter("idModeP"),request.getParameter("typeE"),request.getParameter("typeS"),"-","-","-",idLigne);

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/virer.jsp"); </script>
          <%
          }
          if (acte.compareTo("REPORTER")==0)
          {                          //String daty,                  String datyFin,                   String montant,             String caisse, String devise
           u.reporter(request.getParameter("daty"),request.getParameter("datyFin"),request.getParameter("montant"),request.getParameter("caisse"),request.getParameter("idDevise"),"-","-","-",idLigne);

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/reporter.jsp"); </script>
          <%
          }
          if (acte.compareTo("ANNULER")==0)
          {
            retour=u.annulerEntree(idEntree);

           %>
 		 <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/critereEntree.jsp"); </script>
        <%
          }
        }catch (Exception e){
 %>

<script language="JavaScript"> ///document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




