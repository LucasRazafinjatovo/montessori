<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/listeAutoAnnulation.jsp";
        String lien= null;
        facture.AutorisationAnnulation autoAnnul[] = null;
        bean.TypeObjet to[] = null;
        UserEJB u = null;
        String idFactureMere = null;
        String daty1 = null;
        String daty2 = null;
        String idTypeObjet = null;
        String numObj = null;
        String responsable = null;

%>
<%
daty1 = request.getParameter("daty1");
daty2 = request.getParameter("daty2");
idTypeObjet = request.getParameter("idTypeObjet");
numObj = request.getParameter("numObj");
responsable = request.getParameter("responsable");
if ((idTypeObjet == null)|| idTypeObjet.compareTo("")==0) idTypeObjet="%";
if (daty1==null || daty1.compareTo("")==0) daty1="";
if (daty2==null || daty2.compareTo("")==0) daty2="";
if ((responsable==null)|| responsable.compareTo("")==0) responsable="%";
if ((numObj==null)|| numObj.compareTo("")==0) numObj="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
autoAnnul = u.findAutorisationAnnulation("%",numObj,responsable,daty1,daty2,"%",idTypeObjet);
to = u.findTypeObjet("TypeObjet","%","%");
}catch(Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des autorisations d'annulation</h1>
<table width="360" border="0" align="center" cellpadding="3" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td width="354" height="30" valign="top" class="remarque">Choisir les crit&egrave;res
      de recherche pour la liste des autorisations d'annulation enregistr&eacute;es.</td>
  </tr>
</table>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeAuto" id="listeAuto">
  <table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>

	  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td width="19%" height="20" bgcolor="#C300FF"><strong>Date début :</strong></td>
            <td width="34%"><div align="center">
                <input name="daty1" type="text" class="champ" id="daty1" value="<%=daty1%>" size="10" maxlength="10">
                &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
            <td width="16%" bgcolor="#C300FF"><strong>Date fin:</strong></td>
            <td width="31%"><div align="center">
                <input name="daty2" type="text" class="champ" id="daty22" value="<%=daty2%>" size="10" maxlength="10">
                &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
          </tr>
          <tr>
            <td bgcolor="#C300FF" height="20"><strong>Type Objet :</strong></td>
            <td><div align="center">
                <select name="idTypeObjet" class="champ" id="select">
                  <option value="%">Tous</option>
                  <%
                          for(int i=0;i<to.length;i++){
                          %>
                  <option value="<%=to[i].getId()%>" <%if(to[i].getId().compareTo(idTypeObjet)==0)out.print("selected");%>><%=to[i].getVal()%></option>
                  <%
                          }
                          %>
                </select>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
            <td bgcolor="#C300FF"><strong>Num&eacute;ro :</strong></td>
            <td><div align="center">
                <input name="numObj" type="text" class="champ" id="numObj2">
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
          <tr>
            <td bgcolor="#C300FF" height="20"><strong>Responsable :</strong></td>
            <td><div align="center">
                <input name="responsable" type="text" class="champ" id="responsable2" value="<%=responsable%>">
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
            <td bgcolor="#C300FF">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
		</td>
    </tr>
    <tr>
      <td height="30">
		  <table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
			  <tr>
				<td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">
				</td>
				<td align="center"> <input name="Annuler" type="reset" class="submit">
				</td>
			  </tr>
			</table>
		</td>
    </tr>
  </table>
</form>
<p class="titreMoyen">
  <script>
var cal1 = new calendar1(document.forms['listeAuto'].elements['daty1']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeAuto'].elements['daty2']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
  <br>
</p>
