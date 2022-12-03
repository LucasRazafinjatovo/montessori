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

%>
<%out.println("apres facture");
acte=request.getParameter("acte");
System.out.println("APRES OP DIRECTEacte = "+acte);
	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
		nature=request.getParameter("nature");
         
          if (acte.compareTo("INSERT")==0)
          {System.out.println("INSERT = ");
			//out.println("daty sdf"+request.getParameter("dateemission"));
			rep=u.creerOpDirecteSansVisa(request.getParameter("daty"), request.getParameter("designation"), request.getParameter("idLigne"), request.getParameter("facture"), request.getParameter("montantTTC"), request.getParameter("fournisseur"), request.getParameter("remarque"));
			//out.println("fournisseur = "+request.getParameter("fournisseur"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeOP.jsp");
		  </script>
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




