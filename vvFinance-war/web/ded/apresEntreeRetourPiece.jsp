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

	String numObjet=null;
 String typeObjet = null;
 String mvt=null;
%>
<%
acte=request.getParameter("acte");
out.println("acte = "+acte);

	try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");

          if (acte.compareTo("INSERT")==0)
          {
            u.createRetourPiece(request.getParameter("idOP"),request.getParameter("daty"),request.getParameter("refpiece"),request.getParameter("remarque"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/entreeRetourPiece.jsp");
                  </script>
          <%}

        }catch (Exception e){
                    e.printStackTrace();
 %>

<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
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




