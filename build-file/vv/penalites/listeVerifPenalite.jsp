<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

	String apres="facture/listeFacture.jsp";
	String lien= null;
        UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");

lien=(String)session.getValue("lien");

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h2>Liste des p&eacute;nalit&eacute;s v&eacute;rifi&eacute;es<br>
</h2>
<table width="500" border="0" align="center">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <!--DWLayoutTable-->
        <tr>
          <td colspan="12" height="1" bgcolor="#CCCCCC"></td>
        </tr>
        <%
  for(int i=0;i<5;i++){
  %>
        <tr>
          <td height="25" bgcolor="#CCCCCC"></td>
          <td align="center"><strong>Fact</strong></td>
          <td align="center"><strong>Client</strong></td>
          <td bgcolor="#CCCCCC"></td>
          <td align="left"><div align="center"><strong>Type</strong></div></td>
          <td bgcolor="#CCCCCC"></td>
          <td align="right"><div align="center"><strong>Montant (Ar)</strong></div></td>
          <td bgcolor="#CCCCCC"></td>
          <td valign="middle" bgcolor="#FFFFFF"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td bgcolor="#cccccc"></td>
        </tr>
        <tr>
          <td width="1" height="25" bgcolor="#CCCCCC"></td>
          <td width="47" align="center"><input type="radio" name="codeProduit" value="fafa"></td>
          <td width="148" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="1" bgcolor="#CCCCCC"></td>
          <td width="121" align="left"> <div align="center">&nbsp;</div></td>
          <td width="1" bgcolor="#CCCCCC"></td>
          <td align="right" width="111">Ar</td>
          <td width="1" bgcolor="#CCCCCC"></td>
          <td width="60" valign="middle" bgcolor="#FFFFFF"><div align="center">&nbsp;<a href="#">Voir
              d&eacute;tails</a></div></td>
          <td width="3" bgcolor="#cccccc"></td>
        </tr>
        <%
   }
  %>
        <tr>
          <td colspan="12" height="1" bgcolor="#CCCCCC"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><div align="center">
        <input type="submit" name="Submit" value="Facturer">
      </div></td>
  </tr>
</table>
<h2>&nbsp; </h2>
<div align="center"><br>
</div>
