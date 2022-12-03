<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresVisualiserOrdonnerRecette.jsp";
        String lien= null;
         UserEJB u = null;
         OrdonnerPayement op = null;
        TypeObjet source[] =null;
                TypeObjet ag[] =null;
		UnionIntraTable[] lcc = null;
                String idFact = null;
                facture.Tva tva = null;
				String nature=null;
String numObjet = null;
String typeObjet = null;
String idLigne= null;
String idDED = null;
     %>
<%
idFact=request.getParameter("idFacture");
typeObjet=request.getParameter("typeObjet");
  numObjet=request.getParameter("numObjet");
  idLigne =request.getParameter("idLigne");

  idDED =request.getParameter("idDED");




nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
if(idFact == null) idFact = "";
try{
Visa vop = new Visa();
vop.setNomTable("VISAOR");
Visa[] laos = (Visa[])CGenUtil.rechercher(vop,null,null," and idobjet='"+numObjet+"'");

u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
op = u.findOr(numObjet,"%","","","","","%")[0];
UnionIntraTableUtil uit = new UnionIntraTableUtil();
uit.setNomTable("ORFCLC");
lcc = (UnionIntraTable[])uit.rechercher(2,numObjet);
u.devaliderUnionIntraTable(lcc,"ORFCLC");

%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Modifier Ordonner Payement </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
         <tr>
            <td class="left">Réf OP : <span class="remarque">*</span></td>
            <td align="center"><input name="numObjet" type="text" class="champ" readonly="readonly"  id="numObjet" value="<%=numObjet%>" /></td>
            <td align="left">&nbsp;<input name="choix3" type="button" disabled onClick="pagePopUp('ded/choix_ded.jsp?champReturn=idDed')" value="..." class="submit"><img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>

         <tr>
            <td class="left">Ded num : <span class="remarque">*</span></td>
            <td align="center"><input name="idDed" type="text" class="champ" readonly="readonly"  id="idDed" value="<%=idDED%>" /></td>
            <td align="left">&nbsp;<input name="choix3" type="button" disabled onClick="pagePopUp('ded/choix_ded.jsp?champReturn=idDed')" value="..." class="submit"><img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
 <tr>
            <td class="left">Date : </td>
            <td align="center"><input name="daty" type="text" class="champ" id="daty" value="<%=Utilitaire.convertDatyFormtoRealDatyFormat(op.getDaty()+"") %>" /></td>
            <td align="left">&nbsp;
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Montant : </td>
            <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" value="<%=op.getMontant()%>"/></td>
            <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Remarque : </td>
            <td align="center">
				<textarea name="remarque" class="champ" id="remarque"><%=op.getRemarque()%></textarea></td>
            <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
          <input name="acte" type="hidden" id="acte" value="UPDATE">
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
<%
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>