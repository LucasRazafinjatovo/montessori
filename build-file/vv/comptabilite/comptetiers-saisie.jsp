<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="comptabilite/apresCompta.jsp";
        String lien= null;
        UserEJB u = null;
        Societe caiss[] = null;

     %>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
 caiss = u.findSociete("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>ENREGISTREMENT Compte tiers</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(idsociete.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">Société : <span class="remarque">*</span></td>
            <td align="center">
              <select name="idsociete" class="champ" id="tva">
                <% for(int i=0;i<caiss.length;i++){ %>
					<option value="<%=caiss[i].getId()%>"><%=caiss[i].getNom()%></option>
                <% } %>
              </select>
				&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">Compte : <span class="remarque">*</span></td>
            <td align="center">
             <input name="compte" type="text" id="compte" value=""/>
                        <td align="center"><div align="left">
              <input name="choix3" type="button" onClick="pagePopUp('comptabilite/choixCompteComptaTiers.jsp?champReturn=compte')" value="..." class="submit">
            </div></td>
&nbsp;<td align="center"><div align="left">
             </div></td>
          </tr>

         <tr>
           <td class="left">Reference tiers : <span class="remarque">*</span></td>
           <td align="center">
             <input name="reftiers" type="text" id="reftiers" value=""/>
			<td align="center"><div align="left">
              <input name="choix3" type="button" onClick="pagePopUp('comptabilite/choixPersonne.jsp?champReturn=reftiers;nom;nif;telephone;adresse;stat;rcs;typetiers')" value="..." class="submit">
            </div></td>
&nbsp;<td align="center"><div align="left">
             </div></td>
         </tr>
		 <tr>
            <td class="left">Nom : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="nom" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">NIF : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="nif" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">T&eacute;l&eacute;phone : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="telephone" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">Adresse : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="adresse" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">STAT : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="stat" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">RCS : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="rcs" value=""/>&nbsp;
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
		  <tr>
            <td class="left">Type tiers : <span class="remarque">*</span></td>
            <td align="center">
			  <select name="typetiers" class="champ" id="typetiers">
				<option value="F">Fournisseur</option>
				<option value="C">Client</option>
				<option value="E">Personnel</option>
              </select>
			</td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
          <input name="acte" type="hidden" id="acte" value="insert">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">          </td>
          <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" /></td>
 <input name="bute" type="hidden" id="bute" value="comptabilite/comptetiers-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="comptabilite.CompteTiers">
  </tr>
</table>
    </td>
        </tr>
</table>










</form>
<div align="center">
  <span class="remarque">(*) Champs obligatoires</span></div>