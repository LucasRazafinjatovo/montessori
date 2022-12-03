<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresService.jsp";
        String lien= null;
        Service svc = null;
        UserEJB u = null;
        facture.SCatService scatserv[] = null;
        TypeObjet dev[] = null;
        TypeObjet unite[] = null;
        String idService = null;
        Client clt[]=null;
     %>
<%
idService = request.getParameter("idService");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
svc = u.findService(idService, "%", "", "","%","%","%","%")[0];
scatserv = u.findSCatService("%","%","%","%");
dev = u.findTypeObjet("Devise","%","%");
unite = u.findTypeObjet("unite","%","%");
clt = u.findClient("%","%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
}catch(Exception e){
     %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
     <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier service</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="service" id="service">
  <table width="450" align="center" cellpadding="0" cellspacing="0">
 <tr><td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td height="23" valign="top" class="left">D&eacute;signation :</td>
            <td valign="top"><input name="designation" type="text" class="champ" id="designation" value="<%=svc.getDesignation()%>"></td>
          </tr>
          <tr>
            <td width="144" height="23" valign="top" class="left">Sous-cat&eacute;gorie
              :</td>
            <td width="244" valign="top"> <select name="idSsCat" class="champ" id="idSsCat">
                <%
	  for(int i=0;i<scatserv.length;i++){
	  %>
                <option value="<%=scatserv[i].getIdScatService()%>" <%if(scatserv[i].getIdScatService().compareTo(svc.getIdSCatService())==0)out.print("selected");%>><%=scatserv[i].getNomSCatService()%></option>
                <%
		}
		%>
              </select></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Date d&eacute;but validit&eacute;
              :</td>
            <td valign="top"><input name="dateDebutValide" type="text" class="champ" id="dateDebutValide" value="<%=Utilitaire.formatterDaty(svc.getDatyDebutValid())%>" size="18" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" width="16" height="16" align="absmiddle" border="0"></a></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Unit&eacute; :</td>
            <td valign="top"> <select name="idUnite" class="champ" id="idUnite">
                <%
          for(int i=0;i<unite.length;i++){
          %>
                <option value="<%=unite[i].getId()%>" <%if(unite[i].getId().compareTo(svc.getIdUnite())==0)out.print("selected");%>><%=unite[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Prix unitaire :</td>
            <td valign="top" ><input name="pu" type="text" class="champ" id="pu" value="<%=svc.getPrixUnitaire()%>" size="18">
            </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Devise :</td>
            <td valign="top" ><select name="idDevise" class="champ" id="idDevise">
                <%
	  for(int i=0;i<dev.length;i++){
	  %>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo(svc.getIdDevise())==0)out.print("selected");%>><%=dev[i].getVal()%></option>
                <%
		}
		%>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Valeur TVA :</td>
            <td valign="top" ><input name="valeurTva" type="text" class="champ" id="valeurTva" value="<%=svc.getIdTva()%>" size="18">
              <input name="acte" type="hidden" id="acte2" value="UPDATE"> <input name="idService" type="hidden" id="acte" value="<%=svc.getIdService()%>">
            </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Client :</td>
            <td valign="top" >
    <select name="idClient" class="champ">
     <%
  for(int i=0;i<clt.length;i++){

  %>
<option value="<%=clt[i].getIdClient()%>" <%if(clt[i].getIdClient().compareTo(svc.getIdClient())==0)%>><%=clt[i].getNom()%></option>
  <%
  }
  %>
</select></td>
          </tr>
        </table>

</td></tr>
<tr><td align="center">
<table width="75%"><tr><td height="30" align="center"><input type="submit" name="Submit" value="Valider" class="submit"></td><td align="center"><input type="reset" name="Submit2" value="Annuler" class="submit"></td></tr></table>
        <div align="center"></div></td></tr></table>
  <br>
<br>


  <div align="center">
    <script language="">
var cal1 = new calendar1(document.forms['service'].elements['dateDebutValide']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  </div>
</form>