<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet dev[] = null;
MvtStock mvt= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
LettrageMvt[] letMvt =  null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
mvt=u.findMvtStock(id,"","","%","%")[0];

 letMvt = u.findLettrageMvt("%",id,"%");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{

  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script language="javascript">
function page(page_dest){
        document.location=page_dest;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Enregistrement Magasin destination</h1>

<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>

 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
  <tr>
   <td  valign="top" class="left">Référence mouvement :</td>
   <td  valign="top">&nbsp;<%=mvt%>
   </td>
 </tr>
          <tr>
   <td  valign="top" class="left">Type mouvement :</td>
   <td  valign="top"><font color="#FF0000"><%=mvt.getTypeMvt()%></font>
   </td>
 </tr>
 <tr>
   <td  valign="top" class="left">Date :</td>
   <td  valign="top">&nbsp;<%=Utilitaire.formatterDaty(mvt.getDaty())%>
   </td>
 </tr>
 <tr>
   <td  valign="top" class="left">Designation
     :</td>
   <td valign="top">&nbsp;<%=mvt.getDesignation()%></td>
 </tr>
 <tr>
   <td valign="top" class="left">Valeur</td>
   <td valign="top">&nbsp;<%=mvt.getDebit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Magasin  </td>
   <td valign="top">&nbsp;<font color="#003399"><%=mvt.getCompte()%></font>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Remarque :</td>
   <td valign="top">&nbsp;<%=mvt.getRemarque()%></td>
 </tr>

      </table></td>
  </tr>
</table>


</form>

<hr align="center" color="#0099FF" noshade size="1" width="85%">

<h1>Ajouter Magasin </h1>
<form name="form1" method="post" action="<%=lien%>?but=stock/apresMagasinDest.jsp">
 <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
    <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">
          </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Designation
            :</td>
          <td valign="top">&nbsp; <input name="designation" type="text" class="champ" id="designation" value="" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td valign="top" class="left">Magasin
            :</td>
          <td valign="top">&nbsp; <input name="magasin" type="text"  class="champ" id="magasin" value="" size="20" maxlength="10"><input type="button" id="tiers" value="..."></td>
        </tr>

        <tr>
          <td valign="top" class="left">Quantit&eacute;</td>
          <td valign="top">&nbsp; <input name="quatite" type="text"  class="champ" id="quatite" value="" size="20" maxlength="10">		  </td>
        </tr>
		<tr>
          <td  valign="top" class="left">Date :</td>
          <td valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="" size="10" maxlength="10"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">          </td>
        </tr>
         <tr>
          <td valign="top" class="left">Remarque
            :</td>
          <td valign="top">&nbsp;  <textarea name="noteExplicative" cols="40" rows="5"></textarea>
</td>
        </tr>
      </table>
</td></tr></table>

  <input name="acte" type="hidden" id="acte" value="INSERT">
  <input name="idMvmt" type="hidden" id="" value="">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter" onClick="MM_validateForm('designation','','R','qte','','RisNum','pu','','RisNum');return document.MM_returnValue">
        <input type="reset" name="Submit2" value="Annuler">
		 <input type="button" onclick="page('<%=lien%>?but=stock/confirmation_mouvement_entrepot.jsp&id=<%=id%>')" name="Submit2" value="Terminer">
  </div></form>



<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
    <td width="66"  height="20" align="center" >Magasin dest </td>
          <td width="132" align="center" >&nbsp;Quantit&eacute;</td>
                 <td width="26" align="center" valign="middle"></td>
     </tr>
		<%

		for(int i=0;i<letMvt.length;i++){
mvt1=u.findMvtStock(letMvt[0].getParent(),"","","%","%")[0];
        %>
     <tr>
          <td width="66"  height="20"><%=mvt1.getCompte()%></td>
          <td width="132"><%=mvt1.getCredit()%></td>
          <td width="26" align="center" valign="middle">
	</td>
        </tr>
        <%
        }
		%>
	  </table>
		</td></tr></table>


