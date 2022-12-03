<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresVisualiserOrdonnerPayement.jsp";
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
double montantObjet = 0.0;
OrdonnerPayement op = null;
     %>
<%
idFact=request.getParameter("idFacture");
String indiceSelection=request.getParameter("indice");
montantObjet = 0.0;

  numObjet=request.getParameter("numObjet"+indiceSelection);

nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
op=u.findOp(numObjet,"%","%","","","%","%","%")[0];
 montantObjet =  op.getMontant();

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Visualiser Ordonner Payement </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">Ded num : <span class="remarque">*</span></td>
            <td align="center"> <%=op.getIdDed()%>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>

          <tr>
            <td class="left">Ligne: <span class="remarque">*</span></td>
            <td align="center">      <%=op.getIdLigne()%>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">        </td>
          </tr>

          <tr>
            <td class="left">Montant (HT) : </td>
            <td align="center"><%=Utilitaire.formaterAr(op.getMontant())%>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Remarque : </td>
            <td align="center"> <%=op.getRemarque()%>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
		  <input name="nature" type="hidden" id="nature" value="<%=nature%>">

<input name="numObjet" type="hidden" id="numObjet" value="<%=op.getId()%>">
			  <input name="montantObjet" type="hidden" id="montantObjet" value="<%=montantObjet%>">
			 <input name="typeObjet" type="hidden" id="typeObjet" value="<%=Constante.getObjetOp()%>">
 <input name="tableJointure" type="hidden" id="tableJointure" value="<%=Constante.getObjetOp()%>">

          <input name="acte" type="hidden" id="acte" value="viser">
              <input type="submit" name="Submit" value="viser" class="submit" onClick="acte.value='viser'">&nbsp;
			  <input type="submit" name="Submit" value="Payer" class="submit" onClick="acte.value='payer'">&nbsp;
			  <input type="submit" name="Submit" value="Modifier" class="submit" onClick="acte.value='modif'">
			   <input type="submit" name="Submit" value="Joindre avec LcDetail" class="submit" onClick="acte.value='jLC'">
			  <input type="submit" name="Submit" value="Visualiser jointure LcDetail" class="submit" onClick="acte.value='vJointureLC'">


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
var cal1 = new calendar1(document.forms['recette'].elements['dateemission']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>