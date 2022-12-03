<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        penalite.Accident penAcc[] = null;
        UserEJB u = null;
        historique.MapUtilisateur ut=null;
        String nomEmp=null;
        String datyInf = null;
        String datySup = null;

%>
<%
nomEmp = request.getParameter("nomEmp");
datyInf= request.getParameter("datyInf");
datySup = request.getParameter("datySup");
%>
<%
if(datyInf== null)datyInf="";
if(datySup== null)datySup="";
if(nomEmp == null) nomEmp ="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");

 ut=u.getUser();
 }
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Synth&egrave;se pointage</h1>
<form action="<%=lien%>?but=penalites/synthesePointage.jsp" method="post" name="synthPointage" id="synthPointage">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
            <td width="238" height="24" class="left"> Date d&eacute;but :<strong>
              </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datyInf" type="text" id="nomClient2" value="<%=datyInf%>">&nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </strong></td>
        </tr>
        <tr>
            <td width="238" height="24" class="left"> Date fin :<strong> </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datySup" type="text" id="nomClient2" value="<%=datySup%>">&nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> 
              </strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
            <input name="Submit" type="submit" class="submit" value="Envoyer">
          </td>
          <td align="center">
<input name="Submit2" type="reset" class="submit" value="R&eacute;tablir">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>

<script language="JavaScript">
var cal1 = new calendar1(document.forms['synthPointage'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['synthPointage'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
