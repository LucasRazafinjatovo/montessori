<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="historique.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresTraficEvp.jsp";
	String lien= null;
	Service svc[] = null;
        UserEJB u = null;
        facture.SCatService sCatServ = null;
         TraficConteneur tc = null;
         String idTrafic=null;

%>
<%
idTrafic= request.getParameter("idTrafic");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient
//String idTrafic, String datyDebut, String datyFin, String idserv
tc=u.findTrafic(idTrafic,"","","%")[0];
svc = u.findService("%", "%", "", "", "%", "%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Modifier Trafic EVP </h1>
<form name="traffic" method="post" action="<%=lien%>?but=<%=apres%>">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">

          <tr>
            <td width="203" class="left"> &nbsp;Date :</td>
            <td> <div align="center">
                <input name="date" type="text" class="champ" id="date" maxlength="10" value="<%=Utilitaire.formatterDaty(tc.getDaty())%>">
                &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </div></td>
          </tr>
          <tr>
            <td  align="left" valign="top" class="left">&nbsp;Mois de :</td>
            <td  align="center" valign="top"> <select name="dateDebut" class="champ" id="dateDebut">
                <option value="1">janvier</option>
                <option value="2">f&eacute;vrier</option>
                <option value="3">mars</option>
                <option value="4">avril</option>
                <option value="5">mai</option>
                <option value="6">juin</option>
                <option value="7">juillet</option>
                <option value="8">ao&ucirc;t</option>
                <option value="9">sept.</option>
                <option value="10">oct.</option>
                <option value="11">nov.</option>
                <option value="12">d&eacute;c.</option>
              </select>&nbsp;
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td align="left" valign="top" class="left">&nbsp;Année :</td>
            <td  align="center" valign="top"> <input name="dateFin" type="text" class="champ" id="dateFin" size="4" maxlength="4" value="<%=Utilitaire.getAnnee(tc.getPeriodeDebut())%>">&nbsp;
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left"> &nbsp;Service :</td>
            <td align="center">
<select name="idService" class="champ" id="idService">
                <%
for(int i=0;i<svc.length;i++){
  if(svc[i].getIdSCatService().compareTo("scat2")==0){
%>
                <option value=<%=svc[i].getIdService()%> <%if(svc[i].getIdService().compareTo("serv18")==0)out.print("selected");%>><%=svc[i].getDesignation()%></option>
                <%
  }
}
%>
              </select>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td height="20" class="left"> &nbsp;Nombre de conteneur :</td>
            <td height="20"> <div align="center">
                <input name="nombre" type="text" class="champ" id="nombre" value="<%=(long)tc.getNombre()%>">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
          <tr>
            <td valign="top" class="left"> &nbsp;Remarque :</td>
            <td><div align="center">
                <textarea name="remarque" class="champ" id="remarque"><%=tc.getRem()%></textarea>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
        </table>
        <input name="acte" type="hidden" id="acte" value="UPDATE">
        <input name="idTrafic" type="hidden" id="idTrafic" value="<%=tc.getIdTrafic()%>"> </td>
    </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
<input name="Submit" type="submit" class="submit" value="Enregistrer">
            </td>
            <td align="center">
<input name="Submit2" type="reset" class="submit" value="Annuler">
            </td>
  </tr>
</table>

      </td>
    </tr>
  </table>
</form>
<p>
  <script language="javascript">
var cal1 = new calendar1(document.forms['traffic'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['traffic'].elements['dateDebut']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['traffic'].elements['dateFin']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>
</p>
</body>
</html>
