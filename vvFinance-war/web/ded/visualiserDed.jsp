<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresVisualiserDed.jsp";
        String lien= null;

        UserEJB u = null;

        String indiceSelection = null;
        String numObjet = null;
        String nature =null;
         Ded ded[]= null;
         String idFact = null;
     %>
<%

   indiceSelection=request.getParameter("indice");
  numObjet=request.getParameter("numObjet"+indiceSelection);
  idFact=request.getParameter("idDED");
     nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";

try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
//ded=u.findDed(numObjet,"%","","","%","%","%","%","%")[0];
ded=u.findDed(idFact, "%","","","","","%","%","%");
//ResultatEtSomme rs=u.findDedLcPage(idFact,"%", "", "", "", "", "%","%" ,"%", "%","%", "%", "%", "1", "12", 1);

  //      ded=(DedLc[])rs.getResultat();


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


<h1>Details Demande Depense num <%=numObjet%></h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">Designation: <span class="remarque">*</span></td>
            <td align="center">      <%=ded[0].getDesignation()%>        &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center">         <%= Utilitaire.formatterDaty(ded[0].getDaty())%>     &nbsp; </a>
            </td>
          </tr>
          <tr>
            <td class="left">Fournisseur: <span class="remarque">*</span></td>
            <td align="center">    <%=ded[0].getTiers()%>                        &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Montant (HT) : </td>
            <td align="center">    <%=ded[0].getMontantHt()%>          &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Taux tva : <span class="remarque">*</span></td>
            <td align="center">
&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
          </tr>
          <tr>
            <td class="left">TVA : </td>
            <td align="center">     <%=ded[0].getTaxe()%>         &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Remarque : </td>
            <td align="center">     <%=ded[0].getRemarque()%>         &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input name="typeObjet" type="hidden" id="nature" value="<%=Constante.getObjetDed() %>">
<input name="idLigne" type="hidden" id="idLigne" value="<%=ded[0].getIdLigne()%>">
   <input name="numObjet" type="hidden" id="numObjet" value="<%=ded[0].getId()%>">
<input name="montantObjet" type="hidden" id="montantObjet" value="<%=ded[0].getMontantHt()%>">
 <input type="hidden" name="acte" value="viser" />

   <input type="submit" name="Submit" value="Joindre avec LCDetail" class="submit"
 onClick="acte.value='jLCDetail'">&nbsp;
			 <input type="submit" name="Submit" value="Visualiser Jointure LcDetail" class="submit"
 onClick="acte.value='vJointureLC'">  </td>
 </tr>
 <tr><td align="center">
				&nbsp;
			    <input type="submit" name="Submit" value="Viser Ded" class="submit"
 onClick="acte.value='visa'">
				&nbsp;
			    <input type="submit" name="Submit" value="Ordonnancer" class="submit"
 onClick="acte.value='ordonnancer'">&nbsp;
  <input type="submit" name="Submit" value="Modifier Ded" class="submit"
 onClick="acte.value='modifier'">

          </td>

  </tr>
</table>
    </td>
        </tr>
</table>


</form>
<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>