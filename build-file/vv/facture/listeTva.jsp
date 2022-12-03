<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresInit.jsp";
	String lien= null;
        Tva tva[] = null;
        UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
tva = u.findTva("%","%","","");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste TVA </h1>
 <table border="0" align="center" cellpadding="0" cellspacing="0" width="600">
        <!--DWLayoutTable-->
        <tr>
          <td>
 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td height="23" align="center" valign="middle" >Date d&eacute;but
            d'application </td>
          <td align="center" valign="middle">&nbsp; Valeur</td>
        </tr>
		<%
		for(int i=0;i<tva.length;i++){
		%>
        <tr>
          <td height="23" align="center"><%=Utilitaire.formatterDaty(tva[i].getDatyDebutValid())%></td>
		  <td width="164" align="center" valign="middle"><%=tva[i].getValTva()%></td>
        </tr>
		<%
		}
		%>
      </table>
</td>
</tr>
</table>
<br>
<br>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr> 
    <td width="486" height="32" class="remarque"><div align="right">(*) Date début 
        d'application : la date d'application de la valeur de la TVA donnée.</div></td>
  </tr>
</table>
