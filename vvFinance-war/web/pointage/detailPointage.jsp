<%@ page import="user.*" %>
<%@ page import="pointage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        UserEJB u = null;
	pointage.Pointage temp[]=null;
	pointage.Pointage e=null;
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
//findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception, RemoteException;
temp=u.findPointage(request.getParameter("idPointage"),"%","","","","","%","%","%","%","%");
if (temp.length<=0) throw new Exception("Pointage non existant");
e=temp[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail : Pointage N&deg; <%=e.getTuppleID()%></h1>
<table cellspacing="0" cellpadding="0" align="center" width="445">
<tr><td width="441">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td class="left" height="38">
<div align="right">Nom :</div></td>
          <td><div align="center"><%=e.getIdUser()%></div></td>
        </tr>
        <tr>
          <td width="186" height="35" class="left">
<div align="right">Date :</div></td>
          <td width="245"><div align="center"><%=Utilitaire.formatterDaty(e.getDaty())%></div></td>
        </tr>
        <tr>
          <td class="left" height="38">
<div align="right">Heure :</div></td>
          <td><div align="center"><%=e.getHeure()%></div></td>
        </tr>
        <tr>
          <td class="left" height="36">
<div align="right">Type : </div></td>
          <td><div align="center"><%=e.getIdType()%> </div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Ip : </div></td>
          <td><div align="center"><%=e.getIp()%> </div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Machine :</div></td>
          <td><div align="center"><%=e.getMachine()%></div></td>
        </tr>
        <tr>
          <td class="left" height="42">
<div align="right">Agence :</div></td>
          <td><div align="center"><%=e.getAgence()%></div></td>
        </tr>
      </table>

</td>
</tr>
</table>

