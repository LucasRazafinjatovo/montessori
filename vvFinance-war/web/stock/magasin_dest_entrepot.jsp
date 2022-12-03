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
 TypeObjet ut[] = null;
MvtStock mvt= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
LettrageMvt[] letMvt =  null;
String type = null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
     type = request.getParameter("type");
mvt=u.findMvtStock(id,"","","%","%")[0];
ut = u.findTypeObjet("unitMvt","%","%");
 letMvt = u.findLettrageMvt("%",id,"%");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/
//VIEW RELIANT LETTRAGE ET MOUVEMENT DE STOCK
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
<h1>Enregistrement Entrée Magasin</h1>
<h2>Mouvement parent</h2>
<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>

 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
  <tr>
   <td  valign="top" class="left">Référence mouvement :</td>
   <td  valign="top">&nbsp;<%=mvt.getId()%>
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

<h1>Entrée Magasin </h1>
<form name="form1" method="post" action="<%=lien%>?but=stock/apresMagasinDestEntrepot.jsp">
 <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
    <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10">
  <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>

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
          <td valign="top">&nbsp; <select name="compteMag">
                         <%
                  for(int i=0;i<cMag.length;i++){
                  %>
  <option value="<%=cMag[i].getId()%>"><%=cMag[i].getVal()%></option>
  <%
                   }
                  %>
						</select></td>
        </tr>

        <tr>
          <td valign="top" class="left">Quantit&eacute;</td>
          <td valign="top">&nbsp; <input name="valeur" type="text"  class="champ" id="valeur" value="" size="20" maxlength="10">
		  &nbsp;&nbsp;unité<select name="unite">
<%
                                          for (int t=0;t<ut.length;t++){
                                                       %>
                                                          <option value="<%=ut[t].getTuppleID()%>"><%=ut[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select>


		  		  </td>
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
  <input name="id" type="hidden" id="id" value="<%=id%>">
  <input name="type" type="hidden" id="type" value="<%=type%>">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter">
        <input type="reset" name="Submit2" value="Annuler">
		 <input type="button" onclick="page('<%=lien%>?but=stock/confirmation_mouvement_entrepot.jsp&id=<%=id%>')" name="Submit2" value="Terminer">
  </div></form>



<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
<td width="66"  height="20" align="center">-</td>
 <td width="66"  height="20" align="center" >Date </td>
 <td width="66"  height="20" align="center" >Designation </td>
    <td width="66"  height="20" align="center" >Magasin dest </td>
          <td width="132" align="center" >&nbsp;Quantit&eacute;</td>
                 <td width="26" align="center" valign="middle">Action</td>
     </tr>
		<%

		for(int i=0;i<letMvt.length;i++){
mvt1=u.findMvtStock(letMvt[0].getParent(),"","","%","%")[0];
        %>
     <tr>
     <td width="66"  height="20">
 <a href="<%=lien%>?but=stock/confirmation_mouvement.jsp&id=<%=mvt1.getId()%>">[<%=mvt1.getId()%>]</a>
<%=Utilitaire.formatterDaty(mvt1.getDaty())%></td>
        <td width="66"  height="20"><%=Utilitaire.formatterDaty(mvt1.getDaty())%></td>
           <td width="66"  height="20"><%=mvt1.getDesignation()%></td>
          <td width="66"  height="20"><%=mvt1.getCompte()%></td>
          <td width="132"><%=mvt1.getCredit()%></td>
          <td width="26" align="center" valign="middle">
        <a href="<%=lien%>?but=stock/dossier_mouvement.jsp&id=<%=mvt1.getId()%>&urlRetour=magasin_dest_entrepot.jsp">[Dossier]</a>
        <a href="<%=lien%>?but=stock/saisir_bobine.jsp&id=<%=mvt1.getId()%>&urlRetour=magasin_dest_entrepot.jsp">[Bobine]</a>
	</td>
        </tr>
        <%
        }
		%>
	  </table>
		</td></tr></table>

<script language="JavaScript">
<!--dateParution
    var cal1 = new calendar1(document.all.date);
     cal1.year_scroll = false;
     cal1.time_comp = false;


     //-->
</script>
