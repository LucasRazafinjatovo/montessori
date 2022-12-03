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
       String  nature= null;
String numObjet = null;
String designation= null;
String qte = null;
String puHT= null;
String rem = null;
String tableDet = null;

%>
<%out.println("apres facture");
acte=request.getParameter("acte");
out.println("acte = "+acte);
nature= request.getParameter("nature");
numObjet = request.getParameter("numObjet");
designation= request.getParameter("designation");
qte = request.getParameter("qte");
puHT= request.getParameter("puHT");
rem = request.getParameter("rem");
tableDet= request.getParameter("tableDet");


	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
		nature=request.getParameter("nature");
          if (acte.compareTo("INSERT")==0)
          {
           System.out.println( tableDet+"   "+  numObjet+"   "+ designation+"   "+ qte+"   "+ puHT+"   "+ rem);
        u.createDetail(tableDet, numObjet,designation,  qte,puHT, rem);
        %>

               <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/detailGen.jsp&tableDet=<%=tableDet%>&numObjet=<%=numObjet%>&nature=<%=nature%>"); </script>

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




