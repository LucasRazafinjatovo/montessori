<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresOpDirect.jsp";
        String lien= null;
                facture.Client clt[] = null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        Tva dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
                TypeObjet ag[] =null;
        Caisse caiss[] = null;
                String idFact = null;
                facture.Tva tva = null;
				String nature=null;

     %>
<%
idFact=request.getParameter("idFacture");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
dev = u.findTva("%", "%","","");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
//dev = u.loadTva(Utilitaire.dateDuJour());
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


<h1>Ordre de paiement directe</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td width="32%" class="left">Designation: <span class="remarque">*</span></td>
            <td width="48%" align="center"> <input name="designation" type="text" class="champ"  id="designation">
              &nbsp;
            </td>
            <td width="20%" align="center"><div align="left"><img src="images/blank.gif" width="17" height="16" align="absmiddle"></div></td>
         </tr>
         <tr>
           <td class="left">id Ligne : <span class="remarque">*</span></td>
           <td align="center">
             <input name="idLigne" type="text" id="idLigne" value=""/>
 <td align="center"><div align="left">
              <input name="choix3" type="button" onClick="pagePopUp('lc/choix_LC.jsp?champReturn=idLigne')" value="..." class="submit">
            </div></td>

&nbsp;
           
           <td align="center"><div align="left">
             </div></td>
         </tr>
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <input name="daty" type="text" class="champ" id="daty" value="<%=Utilitaire.dateDuJour()%>">
&nbsp;            </td>
            <td align="center"><div align="left"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
          </tr>
          <tr>
            <td class="left">Facture: <span class="remarque">*</span></td>
            <td align="center"> <input type="text" class="champ" name="facture" value=""/>&nbsp;            </td>
            <td align="center"><div align="left">
              <input name="choix3" type="button" class="submit" onClick="pagePopUp('facturefournisseur/choix_ff.jsp?champReturn=facture')" value="...">
            </div></td>
          </tr>
          <tr>
            <td class="left">Debit (HT) : </td>
            <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" />
              &nbsp;
            </td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
          <tr>
            <td class="left">Tiers: <span class="remarque">*</span></td>
            <td align="center">
             <input type="text" class="champ" name="fournisseur" value=""/>
&nbsp; </td>
            <td align="center"><div align="left"><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=fournisseur')" value="..." /></div></td>
          </tr>
         
          <tr>
            <td class="left">Remarque : </td>
            <td align="center"> <input name="remarque" type="text" class="champ" id="remarque" maxlength="20">
              &nbsp;
            </td>
            <td align="center"><div align="left"><img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
          <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">          </td>
          <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" /></td>
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