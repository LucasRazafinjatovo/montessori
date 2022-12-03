<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        finance.Entree entree= null;
        String idEntree = null;
%>
<%
try{
idEntree = request.getParameter("idEntree");
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//                   (idEntree, daty1, daty2, client, typeEntree, designation, String idModePaiement, String idDevise, String idCaisse, String idEtat)
entree = u.findEntree(idEntree,"%","%","%","%","%","%","%","%","%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<table width="560" border="1" align="center" bordercolor="#cccccc">
<tr><td>
<table width="500" border="0" cellpadding="0" cellspacing="0" align="center" >
  <!--DWLayoutTable-->
  <tr>
          <td height="21" colspan="5"  align="right">Toamasina, le <%=entree.getDaty()%></td>
  </tr>
  <tr>
          <td height="21" colspan="4" align="center"><strong><font color="15">Recu
            </font><font color="15"> n&deg;</font></strong> <%=entree.getIdEntree()%><br>
      </td>
     </tr>
  <tr>
    <td  height="23" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
     <tr>
          <td height="23" valign="top"><strong>Type :</strong><%=""%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>N° Pi&egrave;ce
            : </strong><%=""%></td>
    </tr>
  <tr>
          <td height="23" valign="top"><strong>Recu de :</strong> <%=entree.getClient()%></td>
    </tr>

  <tr>
    <td height="23"  valign="top"><strong>Pour :</strong></td>

  </tr>
  <tr>
          <td height="23" valign="top" colspan="3"><%=entree.getDesignation()%></td>
   </tr>

  <tr>
          <td height="23" valign="top"><strong>La somme de :</strong></td>

  </tr>


  <tr>
          <td height="23" valign="top"><%=entree.getMontant()%> Ar</td>

  </tr>
  </table>
</td></tr>
</table>
<br>
<table width="560" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
	<td height="1" bgcolor="#999999"></td></tr>
</table>
<table width="560" border="0" cellspacing="0" cellpadding="3" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="364" height="30" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
    <td width="184" valign="top"><strong>Le responsable </strong></td>
  </tr>
</table>
   <br>
<br>
<br>
