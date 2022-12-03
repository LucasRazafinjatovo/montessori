<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        UserEJB u = null;
	facture.Ecriture temp[]=null;
	facture.Ecriture e=null;
        String lien = null;
        String idAuto = null;
%>
<%
idAuto = request.getParameter("idAuto");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
                 //String idEcriture, String daty1, String daty2, String libelle, String compte, String piece
temp=u.findEcriture(request.getParameter("idEcriture"),"","","%","%","%");
if (temp.length<=0) throw new Exception("Ecriture non existant");
e=temp[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail : Ecriture N&deg; <%=e.getIdEcriture()%></h1>
<table cellspacing="0" cellpadding="0" align="center" width="445">
<tr><td width="441">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td width="186" height="35" class="left">
<div align="right">Date :</div></td>
          <td width="245"><div align="center"><%=Utilitaire.formatterDaty(e.getDaty())%></div></td>
        </tr>
        <tr>
          <td class="left" height="38">
<div align="right">Compte :</div></td>
          <td><div align="center"><%=e.getCompte()%></div></td>
        </tr>
        <tr>
          <td class="left" height="36">
<div align="right">Libell&eacute; : </div></td>
          <td><div align="center"><%=e.getLibelle()%> </div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Debit : </div></td>
          <td><div align="center"><%=Utilitaire.formaterAr((double)e.getDebit())%> Ar </div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Credit :</div></td>
          <td><div align="center"><%=Utilitaire.formaterAr((double)e.getCredit())%> Ar</div></td>
        </tr>
        <tr>
          <td class="left" height="42">
<div align="right">Pi&egrave;ce num :</div></td>
          <td><div align="center"><%=e.getPiece()%></div></td>
        </tr>
        <tr>
          <td class="left" height="40">
<div align="right">id Ecriture :</div></td>
          <td><div align="center"><%=e.getIdEcriture()%></div></td>
        </tr>
      </table>

</td>
</tr>
</table>

