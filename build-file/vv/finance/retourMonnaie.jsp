<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="finance/apresRetourMonnaie.jsp";
        String lien= null;

        UserEJB u = null;

  TypeObjet mp[] =null;
    TypeObjet tmvt[] =null;
  Caisse caiss[] = null;
   TypeObjet dev[] =null;

String nature = null;
String numPiece= null;
String numObjet=null;
 String typeObjet = null;
 String montantObjet= null;
 String debit = null;
 String credit = null;
     %>
<%


  
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");



}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>RETOUR MONNAIE </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

          <tr>
            <td class="left">Id Mouvement  : <span class="remarque">*</span></td>
            <td align="center"> <input name="idMvt" type="text" class="champ" id="idMvt" value="">
&nbsp;            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('finance/choix_MVT.jsp?champReturn=idMvt')" value="..." class="submit">  </td>
          </tr>
		   <tr>
            <td class="left">Id Ligne: <span class="remarque">*</span></td>
            <td align="center"> <input name="idLigne" type="text" class="champ" id="idLigne" value="">
&nbsp;            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('lc/choix_LC.jsp?champReturn=idLigne')" value="..." class="submit">  </td>
          </tr>
          <tr>
            <td class="left">Montant : <span class="remarque">*</span></td>
            <td align="center"> <input name="montant" type="text" class="champ" id="montant" value="">
&nbsp;            </td>
            <td align="center"></td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">



	  <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
          <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistreer" class="submit">
          </td>

  </tr>
</table>


    </td>
        </tr>
</table>










</form>
<div align="center">
  <script language="javascript">
  </script>
  <span class="remarque">(*) Champs obligatoires</span></div>