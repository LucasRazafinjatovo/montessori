<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="utilisateur/apresUtilisateur.jsp";
        String lien=null;
        UserEJB u=null;
        MapRoles[] rl = null;
        MapUtilisateur us = null;
        String idUser = null;
%>
<%
  try
{
  idUser=request.getParameter("idUser");
  u=(UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  rl=u.findRole("%");
//(String ref, String user, String nom, String role)
  us=u.findUtilisateurs(idUser,"%","%","%","%","%","%")[0];

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(login.value)&&verifie(newPass.value)&&verifie(nom.value))">
<h1>Modification utilisateur </h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
	<tr>
	<td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Login :</td>
            <td> <input name="login" type="text" class="champ" id="login" value="<%=us.getLoginuser()%>">
              <span class="remarque">*</span> </td>
          </tr>
          <!--<tr>
            <td  class="left">Ancien mot de passe :</td>
            <td> <input name="oldPass" type="password" class="champ" id="oldPass" value="<%=us.getPwduser()%>">
            </td>
          </tr>-->
          <tr>
            <td  class="left">Nouveau mot de passe : </td>
            <td> <input name="newPass" type="password" class="champ" id="newPass" value="<%=us.getPwduser()%>">
              <span class="remarque">*</span> </td>
          </tr>
          <tr>
            <td  class="left">Nom : </td>
            <td> <input name="nom" type="text" class="champ" id="nom" value="<%=us.getNomuser()%>">
              <span class="remarque">*</span> </td>
          </tr>
          <tr>
            <td  class="left">Adresse : </td>
            <td> <input name="adresse" type="text" class="champ" id="adresse" value="<%=us.getAdruser()%>">
              <input name="acte" type="hidden" class="champ" id="adresse" value="UPDATE">
              <input name="idUser" type="hidden" class="champ" id="idUser" value=<%=idUser%>>
            </td>
          </tr>
          <tr>
            <td  class="left">Telephone : </td>
            <td> <input name="telephone" type="text" class="champ" id="telephone" value="<%=us.getTeluser()%>">
            </td>
          </tr>
          <tr>
            <td height="24" valign="top" class="left">Profil de l'utilisateur
              : </td>
            <td valign="top">
			<select name="idRole" id="select">

                <%
          for (int i=0;i<rl.length;i++)
          {
        %>
                <option value="<%=rl[i].getIdRole()%>" <%if(us.getIdrole().compareTo(rl[i].getIdRole())==0) out.print("selected");%>><%=rl[i].getDescRole()%></option>
                <%
          }
        %>
              </select></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
<input type="submit" name="Submit" value="Modifier" class="submit">
            </td>
            <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
  </tr>
</table>
      </td>
	</tr>
</table>

</form>
<div align="center"><span class="remarque">(*) Champs obligatoires</span></div>
