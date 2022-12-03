<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="stock/apresSaisirBobineLivraison.jsp";
  String lien= null;
  UserEJB u = null;
  DetailBobinePoids[] bobine= null;
  LettrageMvt[] letMvt =  null;
  MvtStock mvt= null;

  String apresW=null;
  String id = null;//id du mouvement parent
  String urlRetour = null;
  String cloture="non";// pour tester si le mouvement est déjà cloturer
 %>
<%

     u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");

     id = request.getParameter("id");
      urlRetour = request.getParameter("urlRetour");

      cloture = request.getParameter("cloture");

    if(cloture==null||cloture.trim().compareTo("")==0)cloture="non";
mvt=u.findMvtStock(id,"","","%","%")[0];
bobine =u.findDetailBobine("%","%",id);
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
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Saisie bobine</h1>

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
   <td  valign="top">&nbsp;<%=mvt.getTypeMvt()%>
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
   <td valign="top"><%=mvt.getDesignation()%></td>
 </tr>
 <tr>
   <td valign="top" class="left">Compte </td>
   <td valign="top">&nbsp;<font color="#003399"><%=mvt.getCompte()%></font>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Débit</td>
   <td valign="top"><%=mvt.getDebit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Crédit</td>
   <td valign="top"><%=mvt.getCredit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>

 <tr>
   <td valign="top" class="left">Remarque :</td>
   <td valign="top">&nbsp;<%=mvt.getRemarque()%></td>
 </tr>
  <tr>
   <td valign="top" colspan="2" align="center"><input type="button" onclick="page('<%=lien%>?but=stock/<%=urlRetour%>&id=<%=id%>')" name="Submit2" value="Retour au mouvement"></td>

 </tr>

      </table></td>
  </tr>
</table>

  <div align="center">

      <input type="hidden" value="finalise" name="acte">


  </div>

<hr align="center" color="#0099FF" noshade size="1" width="85%">

    <%
if(cloture.compareTo("non")==0){
%>
<h1>Ajouter bobine</h1>
<form name="form1" method="post" action="<%=lien%>?but=<%=apres%>">
 <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr class="head">
    <td  valign="top" align="center">R&eacute;f&eacute;rence Bobine </td>
    <td valign="top" align="center">Poids</td>
    </tr>
  <tr>
         <td  align="center"><input name="numBob" type="text" id="numBob" size="30" > </td>

      <td width="70"><input name="poids" type="text" id="poids" dir="rtl" size="5"  width="70">      </td>
        </tr>
		  <tr>
         <td  align="center" colspan="2">
<input type="submit" name="Submit" value="Ajouter"><input type="reset" name="Submit2" value="Annuler"></td>
        </tr>
		<input type="hidden" value="<%=id%>" name="id">
<input type="hidden" value="<%=urlRetour%>" name="urlRetour">
  <input name="acte" type="hidden" id="acte" value="INSERT">



</table>
</td></tr></table>
 <br>
	</form>
    <%}
%>



<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
  <td align="center">Id </td>
    <td align="center">&nbsp;Réf. bobine</td>
          <td align="center">&nbsp;Poids </td>

          <td width="26" align="center" valign="middle">&nbsp;</td>

        </tr>
 <%

         for(int i=0;i<bobine.length;i++){

        %>
     <tr>
          <td width="66"  height="20"><%=bobine[i].getId()%></td>
          <td width="132"><%=bobine[i].getNumbobine()%> </td>
          <td width="57"><%=bobine[i].getPoidsbobine()%></td>
          <td width="26" align="center" valign="middle">

<img src="../facture/images/button_drop.png" width="11" height="13" border="0" alt="Supprimer"></td>
        </tr>

		</table>
		</td></tr></table>
