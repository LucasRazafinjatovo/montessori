<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="Utilitaire" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	UnionIntraTable[] det=null;
	String refDet=null;
	String nomTable=null;
	String lien1=null;
	String lien2=null;
        String lien=null;
        UserEJB u = null;
%>
<%
	refDet=request.getParameter("refDet");
	nomTable=request.getParameter("nomTable");
	lien1=request.getParameter("lien1");
	lien2=request.getParameter("lien2");
     try{
       u=(user.UserEJB)session.getValue("u");
       lien=(String)session.getValue("lien");
       det=u.findUnionIntraTable(nomTable, refDet, "%","%","","","","","");
       if(det.length==0)throw new Exception("union non existante");
     }catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.Style3 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
}
.Style5 {color: #666666}
-->
</style>
</head>

<body>
<h1><span class="Style5">Details du <%=nomTable%> numero<%=refDet%> </span><br>
</h1>
<table width="390" border="0" class="monographe">
  <tr>
    <td width="94"><div align="center"><span class="Style3">id</span></div></td>
    <td width="286"><div align="center"><%=det[0].getId()%></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="Style3">id 1 </span></div></td>
    <td><div align="center"><a href=<%=lien%>?but=facture/visualiserFactureClient.jsp&idBC=<%=det[0].getId1()%>&nature=FactureClient><%=det[0].getId1()%></a></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="Style3">id 2 </span></div></td>
    <td><div align="center"><a href=<%=lien%>?but=lc/visualiserDetailLCRecette.jsp&numObjet=<%=det[0].getId2()%>><%=det[0].getId2()%></a></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="Style3">Remarque</span></div></td>
    <td><div align="center"><%=det[0].getRemarque()%></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="Style3">montant</span></div></td>
    <td><div align="center"><%=Utilitaire.formaterAr(det[0].getMontantMere())%></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="Style3">etat</span></div></td>
    <td><div align="center"><%=det[0].getEtatLettre()%></div></td>
  </tr>
</table>
</body>
</html>
