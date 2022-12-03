<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="facturefournisseur/apresEntreeFacture.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        Client clt[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
		TypeObjet ag[] =null;
        Caisse caiss[] = null;
		String idFact = null;



     %>
<%
idFact=request.getParameter("idFacture");
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
System.out.println("lien = "+lien);
dev = u.findTypeObjet("Devise","%","%");
/*tyo = u.findTypeObjet("TypeEntree","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
mp = u.findTypeObjet("ModePaiement","%","%");
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
source = u.findTypeObjet("Beneficiaire","%","%");
caiss = u.findCaisse("%","%","%","%");*/

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>ENREGISTREMENT FACTURE</h1>
<h2><br>
</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr> 
            <td class="left">Fournisseur<span class="remarque">* </span>:</td>
            <td align="center"> <input name="fournisseur" type="text"   id="fournisseur"> 
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
          <tr> 
            <td class="left">N.I.F : <span class="remarque">*</span></td>
            <td align="center"> <input name="nif" type="text"   id="nif" value="" size="10" maxlength="10"> 
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> 
            </td>
          </tr>
          <tr> 
            <td class="left">Stat: <span class="remarque">*</span></td>
            <td align="center"> <input name="stat" type="text"   id="stat"> 
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
          <tr> 
            <td class="left">Tel : </td>
            <td align="center"><input name="tel" type="text"   id="tel" /> 
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
          <tr> 
            <td class="left">Email : </td>
            <td align="center"> <input name="email" type="text"   id="email"> 
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
		   <tr> 
            <td class="left">Adresse: </td>
            <td align="center"> <input name="adresse" type="text"   id="adresse"> 
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
        </table></td>
	</tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="acte" type="hidden" id="acte" value="INSERTF">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
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
