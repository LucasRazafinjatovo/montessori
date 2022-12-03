<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="utilisateur/apresUtilisateur.jsp";
        String lien=null;
        UserEJB u=null;
        MapRoles[] rl=null;
        Direction[] dir=null;
%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dir = u.findDirection("","","","","");
rl=u.findRole("%");
}catch (Exception e)
{%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
return;
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Ajouter nouveau utilisateur </h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifieMotDePasse(passe.value,confirmPass.value))">
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td>
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="168" class="left">Login : <span class="remarque">(*)</span></td>
            <td width="161"><input name="login" type="text"   id="login" size="25" maxlength="25">
            </td>
          </tr>
          <tr>
            <td class="left">Mot de passe : <span class="remarque">(*)</span></td>
            <td><input name="passe" type="password"   id="passe" size="25" maxlength="25">
            </td>
          </tr>
          <tr>
            <td class="left">Confirmer mot de passe : <span class="remarque">(*)</span></td>
            <td><input name="confirmPass" type="password"   id="confirmPass" size="25" maxlength="25">
            </td>
          </tr>
          <tr>
            <td class="left">Nom : <span class="remarque">(*)</span></td>
            <td><input name="nom" type="text"   id="nom" size="25">
            </td>
          </tr>
          <tr>
            <td class="left">Direction : </td>
            <td><select name="adresse" class="champ" id="adresse">
              <%
for(int i=0;i<dir.length;i++){
%>
              <option value="<%=dir[i].getIdDir()%>"><%=dir[i].getLibelledir()%></option>
              <%
}
%>
            </select>
            </td>
          </tr>
          <tr>
            <td class="left">Telephone :</td>
            <td><input name="telephone" type="text"   id="telephone" size="25">
              <input name="acte" type="hidden"   id="acte"  value="INSERT" size="25">
            </td>
          </tr>
          <tr>
            <td height="24" valign="top" class="left">Profil de l'utilisateur
              : </td>
            <td valign="top"><select name="idRole" id="select">
                <%
	  for (int i=0;i<rl.length;i++)
	  {
	%>
                <option value="<%=rl[i].getIdRole()%>"><%=rl[i].getDescRole()%></option>
                <%
	  }
	%>
              </select></td>
          </tr>
        </table>
      </td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit" onClick="MM_validateForm('login','','R','passe','','R','nom','','R');return document.MM_returnValue">
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
