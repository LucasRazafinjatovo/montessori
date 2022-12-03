<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="stock/apresDetailVerification.jsp";
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
Verification verif= null;
DetailVerif[] dv=null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");

%>
<%
  try{
verif=u.findVerification(id,"","","%","%")[0];
  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);
dv=u.findDetailVerif("%", "%", id);
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
<h1>Saisie d&eacute;tail </h1>

<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
 <tr>
   <td width="144" height="23" valign="top" class="left">Date :</td>
   <td width="254" valign="top">&nbsp;<%=Utilitaire.formatterDaty(verif.getDaty())%>   </td>
 </tr><tr>
   <td  height="23" valign="top" class="left">Magasin : </td>
   <td valign="top">&nbsp;<%=verif.getMag()%> 		  </td>
 </tr>
 <tr>
   <td  height="23" valign="top" class="left">Reste</td>
   <td valign="top">&nbsp; <%=verif.getReste()%>  </td>
 </tr>

 <tr>
   <td height="23" valign="top" class="left">Unit&eacute;</td>
   <td valign="top">&nbsp;<%=verif.getUnite()%> </td>
 </tr>
 <tr>
   <td height="23" valign="top" class="left">Controleur</td>
   <td valign="top"> &nbsp;<%=verif.getControleur()%> </td>
 </tr>
 <tr>
   <td height="23" valign="top" class="left">Remarque</td>
   <td valign="top"> &nbsp;<%=verif.getRemarque()%> </td>
 </tr>
      </table></td>
  </tr>
</table>


</form>

<hr align="center" color="#0099FF" noshade size="1" width="85%">

<h1>Saisie d&eacute;tail de la v&eacute;rification </h1>
<form name="form1" method="post" action="<%=lien%>?but=<%=apres%>">
 <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">

        <tr>
          <td valign="top" class="left">Num Bobine
            :</td>
          <td valign="top">&nbsp; <input name="numBob" type="text"  class="champ" id="numBob" value="" size="20" maxlength="10"></td>
        </tr>
        <tr>
          <td valign="top" class="left">Pourcentage reste</td>
          <td valign="top">&nbsp; <input name="pourcentageReste" type="text"  class="champ" id="pourcentageReste" value="" size="20" maxlength="10">		  </td>
        </tr>
        <tr>
          <td  valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="remarque" cols="40" rows="5"></textarea></td>
        </tr>
      </table>
</td></tr></table>

  <input name="acte" type="hidden" id="acte" value="INSERT">
  <input name="id" type="hidden" id="" value="<%=id%>">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter">
        <input type="reset" name="Submit2" value="Annuler">
		  <input type="reset" name="Submit2" value="Terminer">
  </div></form>

<%
if(dv.length>0){
%>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
    <td  height="20">&nbsp;Num Bobine</td>
          <td>&nbsp; Pourcentage reste </td>

          <td align="center" valign="middle">&nbsp;</td>
      </tr>
<%
for (int i=0;i<dv.length;i++){
%>
     <tr>
          <td  height="20"><%=dv[i].getBobinenum()%></td>
          <td><%=dv[i].getPourcentagereste()%></td>
          <td width="26" align="center" valign="middle">
	<a href="">
<img src="images/button_drop.png" width="11" height="13" border="0" alt="Supprimer"></a></td>
        </tr>
<%
}
%>
	  </table>
		</td></tr></table>
<%
}
%>
