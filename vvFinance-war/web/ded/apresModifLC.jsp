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
	String nature=null;
        String apres=null;
%>
<%out.println("apres facture");
acte=request.getParameter("acte");
out.println("acte = "+acte);
	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
		String valcritere=request.getParameter("idligne");
                String cc=request.getParameter("idLC");
                String numFacture=request.getParameter("numFact");
                String ordre=request.getParameter("ordre");
          if (acte.compareTo("update")==0)
          {
            if(ordre.compareTo("op")==0){
             rep=(String)CGenUtil.modifLC("facturefournisseurLC",valcritere,cc,numFacture);
             apres="ded/OPModifier.jsp";
            }
            else if(ordre.compareTo("or")==0){
              rep=(String)CGenUtil.modifLC("factureclientlc",valcritere,cc,numFacture);
              apres="ded/ORModifier.jsp";
            }
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=apres%>&num=<%=request.getParameter("num")%>"); </script>
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




