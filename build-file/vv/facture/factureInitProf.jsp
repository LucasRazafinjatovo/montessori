<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.TypeObjet" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresFactureInit.jsp";
	String lien= null;
	facture.Client clt[] = null;
	facture.SCatService sctserv[] = null;
        TypeObjet ag[] =null;
        TypeObjet enti[] =null;
	UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
sctserv = u.findSCatService("%", "%", "%", "%");
ag = u.findTypeObjet("Agence","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
lien=(String)session.getValue("lien");
}
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  }
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;er une facture proforma(1)</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="factureInit" id="factureInit">
<table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td width="33%" class="left" height="23"> &nbsp;Date :</td>
            <td width="10%">&nbsp;</td>
            <td width="57%"><input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(date.value)">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <span class="remarque">(date cr&eacute;ation facture)</span></td>
          </tr>
          <tr>
            <td height="23" class="left"> &nbsp;Date d&eacute;but :</td>
            <td>&nbsp;</td>
            <td><input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(dateDebut.value)">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <span class="remarque">(date debut facture)</span></td>
          </tr>
          <tr>
            <td height="23" class="left"> &nbsp;Date fin :</td>
            <td>&nbsp;</td>
            <td> <input name="dateFin" type="text" class="champ" id="dateFin" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(dateFin.value)">
              <span class="remarque"><a href="javascript:cal3.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              (date fin facture)</span></td>
          </tr>
          <tr>
            <td height="23" class="left"> &nbsp;Client :</td>
            <td>&nbsp;</td>
            <td>              <input name="idClient" type="text" class="champ" id="idClient2" size="10" maxlength="20" onBlur="cal_prs_date1(dateFin.value)">
            <input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=idClient')" value="..." /></td>
          </tr>
          <tr>
            <td height="23" class="left"> &nbsp;Type :</td>
            <td>&nbsp;</td>
            <td> <select name="idType" class="champ"  id="idType">
                <%
	  for(int i=0;i<sctserv.length;i++){
            if(sctserv[i].getIdCategorie().compareTo("cat2") != 0){
	  %>
                <option value="<%=sctserv[i].getIdScatService()%>" <%if(sctserv[i].getIdScatService().compareTo("scat13")==0)out.println("selected");%>><%=sctserv[i].getNomSCatService()%></option>
                <%
            }
          }
		%>
              </select></td>
          </tr>
          <tr>
            <td height="23" class="left"> Agence :</td>
            <td>&nbsp;</td>
            <td> <select name="agence" class="champ" id="agence">
                <%
for(int i=0;i<ag.length;i++){
%>
                <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo("ag005")==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                <%
}
%>
              </select></td>
          </tr>
          <tr>
            <td height="23" class="left"> Entité :</td>
            <td>&nbsp;</td>
            <td> <select name="entite" class="champ" id="entite">
                <%
for(int i=0;i<enti.length;i++){
%>
                <option value="<%=enti[i].getId()%>" <%if(enti[i].getId().compareTo("ent1")==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                <%
}
%>
              </select></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Parution :</td>

            <td>&nbsp;</td>
            <td><input name="parution" type="text" class="champ" id="parution" ></td>
          </tr>
        </table></td>
  </tr>
  <tr>
      <td height="30">
<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="50%" height="30">
<div align="center">
                <input name="typefact" type="hidden" value="proforma">
                <input type="submit" name="Submit" value="Cr&eacute;er" class="submit" onClick="MM_validateForm('date','','R','dateDebut','','R','dateFin','','R');return document.MM_returnValue">
              </div></td>
          <td width="50%"><div align="center">
                <input name="reset" type="reset" class="submit" value="R&eacute;initialiser">
              </div></td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>



<p align="center">&nbsp;</p>


<script language="javascript">
var cal1 = new calendar1(document.forms['factureInit'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['factureInit'].elements['dateDebut']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['factureInit'].elements['dateFin']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>
