<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;

TypeObjet prt[] = null;
TypeObjet jrnl[] = null;
TypeObjet mg[] = null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;

 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");

     prt = u.findTypeObjet("compte","%","%");
    jrnl= u.findTypeObjet("compte","%","%");
    mg= u.findTypeObjet("compte","%","%");
     /**/

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
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Saisie parution </h1>

<form name="form2" method="post" action="<%=lien%>?but=facture/apresFactureFinal.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date opération:</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">          </td>
        </tr>
		 <tr>
          <td width="144" height="23" valign="top" class="left">Date parution:</td>
          <td width="254" valign="top">&nbsp; <input name="dateParution" type="text" class="champ" id="dateParution" value="" size="10" maxlength="10"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle">          </td>
        </tr>
        <tr>
          <td width="144" height="23" valign="top" class="left">Journal
            :</td>
          <td width="254" valign="top">&nbsp; <select name="journal">
 <%
                                          for (int t=0;t<jrnl.length;t++){
                                                       %>
                                                          <option value="<%=jrnl[t].getTuppleID()%>"><%=jrnl[t].getTuppleID()%> %</option>
                                                       <%
                                          }
                                                       %>

</select></td>
        </tr>
        <tr>
          <td width="144" height="23" valign="top" class="left">Numéro parution :</td>
          <td width="254" valign="top">&nbsp; <input name="numParution" type="text" class="champ" id="numParution" value="" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Nombre de page :</td>
          <td valign="top">&nbsp; <input name="nbrPage" type="text" class="champ" value=""></td>
        </tr>
		<tr>
          <td height="23" valign="top" class="left">Nombre d'exemplaire théorique:</td>
          <td valign="top">&nbsp; <input name="nbrExemplaire" type="text" class="champ" value=""></td>
        </tr>
		 <tr>
          <td height="23" valign="top" class="left">Poids feuille :</td>
          <td valign="top">&nbsp; <input name="poidsFeuille" type="text" class="champ" value=""></td>
        </tr>
		 <tr>
          <td width="144" height="23" valign="top" class="left">Printer
            :</td>
          <td width="254" valign="top">&nbsp; <select name="printer"><option>printer1</option><option>printer2</option><option>printer3</option></select></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="remarque" cols="40" rows="5"><%=fm.getNoteExplicative()%></textarea></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Designation mouvement :</td>
          <td valign="top"> &nbsp;<input name="nbrExemplaire" type="text" class="champ" value=""></td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Magasin</td>
          <td valign="top"><select name="magasin"><option>Magasin1</option><option>Magasin1</option><option>Magasin1</option></select>		  </td>
        </tr>
      </table></td>
  </tr>
</table>


  <div align="center">

      <input type="hidden" value="finalise" name="acte">

    <p>
      <input type="button" onclick="page('dossier_parution.html')"class="submit" value="Enregistrer">
    </p>
  </div>
</form>
<br>
<br>
<hr align="center" color="#0099FF" noshade size="1" width="85%">
<br>
<br>
<h1>Ajouter éléments factures</h1>
<form name="form1" method="post" action="">
 <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
  <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr class="head">
    <td  width="200" valign="top">D&eacute;signation</td>
    <td width="72" valign="top">Quantit&eacute;</td>
    <td width="68" valign="top">Unit&eacute;</td>
    <td width="72" valign="top">PU</td>
      <td  width="50" valign="top">R&eacute;d.</td>
  </tr>
  <tr>
         <td ><input name="designation" type="text" id="designation" size="30" > </td>

      <td width="70"><input name="qte" type="text" id="qte" dir="rtl" size="5"  width="70">
      </td>
        <td valign="top">
        <select  name="idUnite" id="idUnite">
      <%
          for(int i=0;i<u.findTypeObjet("unite","%","%").length;i++){
          %>


        <option value=<%=u.findTypeObjet("unite","%","%")[i].getId()%>><%=u.findTypeObjet("unite","%","%")[i].getVal()%></option>


                <%
                }
                %>

            </select></td>
        <td><input name="pu" type="text" id="pu" dir="rtl" size="15" maxlength="50"></td>
  <td><input name="reductionF" type="text" id="reductionF" dir="rtl" value="0" size="5" maxlength="3"  width="50"></td>
  </tr>

</table>
</td></tr></table>

  <input name="action" type="hidden" id="action" value="ajouter">
  <input name="idFactMere" type="hidden" id="" value="<%=fm.getIdFactureMere()%>">
  <br>
<div align="center">
        <input type="submit" name="Submit" value="Ajouter" onClick="MM_validateForm('designation','','R','qte','','RisNum','pu','','RisNum');return document.MM_returnValue">
        <input type="reset" name="Submit2" value="Annuler">
      </div></form>



<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
    <td width="66"  height="20">&nbsp;RefObjet</td>
          <td width="132">&nbsp; D&eacute;signation </td>
          <td width="57"><div align="center">&nbsp; PU</div></td>
          <td width="41">&nbsp; Qt&eacute; </td>
          <td width="58">&nbsp; Unit&eacute; </td>
          <td width="32">&nbsp;R&eacute;d.</td>
          <td width="142" align="center" valign="middle">&nbsp; Montant</td>
<%
%>
          <td width="26" align="center" valign="middle">&nbsp;</td>
<%
%>
        </tr>
		<%

		for(int i=0;i<ff.length;i++){

        %>
     <tr>
          <td width="66"  height="20">&nbsp;<%=ff[i].getRefObj()%></td>
          <td width="132"><%=ff[i].getDesignation()%> </td>
          <td width="57"><div align="center"><%=Utilitaire.formaterAr(ff[i].getPrixUnitaire())%></div></td>
          <td width="41"><div align="center"><%=ff[i].getQuantite()%></div></td>
          <td width="58"><div align="center"><%=u.findTypeObjet("unite",ff[i].getIdUnite(),"%")[0].getVal()%></div></td>
          <td width="32"><div align="center"><%=ff[i].getReduction()%></div></td>
          <td width="142" align="center" valign="middle"><%=Utilitaire.formaterAr(ff[i].getMontant())%></td>

    <td width="26" align="center" valign="middle">
	<a href="">
<img src="../../application/05-08-08/affichage/facture/images/button_drop.png" width="11" height="13" border="0" alt="Supprimer"></a></td>

        </tr>

		</table>
		</td></tr></table>



