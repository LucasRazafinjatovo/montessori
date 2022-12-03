<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresOrdonnerPayement.jsp";
        String lien= null;
        facture.Client clt[] = null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
        TypeObjet ag[] =null;
        Caisse caiss[] = null;
        String idFact = null;
        facture.Tva tva = null;
        String nature=null;
        String numObjet = null;
        String typeObjet = null;
        String idLigne= null;
     %>
<%
idFact=request.getParameter("idFacture");
typeObjet=request.getParameter("typeObjet");
  numObjet=request.getParameter("numObjet");if (numObjet==null) numObjet="";
  idLigne =request.getParameter("idLigne");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
if(idFact == null) idFact = "";
String idprev = request.getParameter("idprev");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
dev = u.findTypeObjet("Devise","%","%");


}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Ordonner Payement </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
 <tr>
            <td class="left">Date : </td>
            <td align="center"><input name="daty" type="text" class="champ" id="daty" value=<%=Utilitaire.dateDuJour() %> /></td>
            <td align="left">&nbsp;
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
 <tr>
   <td class="left">Designation : </td>
   <td align="center"><textarea name="remarque" class="champ" style="width: 200px; height: 100px;" id="remarque" maxlength="100"><%=request.getParameter("designation")%></textarea></td>
   <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
 </tr>
          <tr>
            <td class="left">Montant : </td>
            <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" value="<%=request.getParameter("montant")%>"/></td>
            <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Montant TVA : </td>
            <td align="center">
              <input name="tva" type="text" class="champ" id="tva">
&nbsp; </td>
            <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>
          <tr>
            <td class="left">Devise : <span class="remarque">*</span></td>
            <td align="center">
              <select name="idDevise" class="champ" id="idDevise">
                <option value="Ar">Ar</option>
                <%
for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                <%
}
%>
              </select>
&nbsp; </td>
            <td align="center"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>
          <tr>
            <td class="left">Fournisseur: <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="fournisseur" value="" maxlenght="100"/>
&nbsp; </td>
            <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=fournisseur')" value="..." />
            <img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
          </tr>
          <tr>
            <td class="left">Lc unique : <span class="remarque">*</span></td>
            <td align="center">          <input type="text" class="champ" name="lc" value=""/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
            <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('lc/listeLC2Choix.jsp?champReturn=lc')" value="lc" /></td>
          </tr>
        
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
    <table width="75%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
			<input name="typeOp" type="hidden" id="typeOp" value="<%=Constante.typeOpNormale%>">
			<input name="acte" type="hidden" id="acte" value="insertavecprev">
			<input name="idprev" type="hidden" id="idprev" value="<%=idprev%>">
			<input name="avecOp" type="hidden" id="acte" value="ok">
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
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>