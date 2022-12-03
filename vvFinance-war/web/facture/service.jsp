<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresService.jsp";
	String lien= null;
        facture.SCatService scatserv[] = null;
        bean.TypeObjet unite[] = null;
        bean.TypeObjet dev[] = null;
        bean.TypeObjet tva = null;
        UserEJB u = null;
        facture.Client clt[] = null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
scatserv = u.findSCatService("%","%","%","%");
unite = u.findTypeObjet("unite","%","%");
dev = u.findTypeObjet("devise","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau service</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
  <table width="450" align="center" cellpadding="0" cellspacing="0" class="monographe">
    <tr><td colspan="3" bgcolor="#999999" height="1"></td></tr>
<tr>
<td width="1" bgcolor="#CCCCCC"></td>
<td>
<table width="400" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
          <!--DWLayoutTable-->
          <tr>
            <td height="23" valign="top" class="left">D&eacute;signation :</td>
            <td valign="top"><input name="designation" type="text" class="champ" id="designation"></td>
          </tr>
          <tr>
            <td width="144" height="23" valign="top" class="left">Sous-cat&eacute;gorie
              :</td>
            <td width="244" valign="top"> <select name="idSsCat" class="champ" id="idSsCat">
                <%
	  for(int i=0;i<scatserv.length;i++){
	  %>
                <option value=<%=scatserv[i].getIdScatService()%>><%=scatserv[i].getNomSCatService()%></option>
                <%
		}
		%>
              </select></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Date d&eacute;but validit&eacute;
              :</td>
            <td valign="top"><input name="dateDebut" type="text" class="champ" id="dateDebut" maxlength="10"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Unit&eacute; :</td>
            <td valign="top"> <select name="idUnite" class="champ" id="idUnite">
                <%
          for(int i=0;i<unite.length;i++){
          %>
                <option value=<%=unite[i].getId()%>><%=unite[i].getVal()%></option>
                <%
                }
		%>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Prix unitaire :</td>
            <td valign="top" ><input name="pu" type="text" class="champ" id="pu" size="18">
            </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Devise :</td>
            <td valign="top" ><select name="idDevise" class="champ" id="idDevise">
                <%
	  for(int i=0;i<dev.length;i++){
	  %>
                <option value=<%=dev[i].getId()%>><%=dev[i].getVal()%></option>
                <%
		}
		%>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Client :</td>
            <td valign="top" >
              <select name="idClient" class="champ" id="idClient">
                <%
          for(int i=0;i<clt.length;i++){
          %>
                <option value="<%=clt[i].getIdClient()%>"><%=clt[i].getNom()%></option>
                <%
          }
        %>
              </select></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Valeur TVA :</td>
            <td valign="top" ><input name="tva" type="text" class="champ" id="tva" size="18" maxlength="3">
            </td>
          </tr>
        </table>

</td>
<td width="1" bgcolor="#CCCCCC"></td>
</tr>
<tr><td colspan="3" bgcolor="#999999" height="1"></td></tr>
</table>
  <input name="acte" type="hidden" id="acte" value="INSERT">
  <br>
<br>


  <div align="center">
    <input type="submit" name="Submit" value="Valider" class="submit">
    <input type="reset" name="Submit2" value="Annuler" class="submit">
  </div>
</form>