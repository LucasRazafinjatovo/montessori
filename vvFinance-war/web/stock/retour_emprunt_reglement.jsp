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
  TypeObjet dev[] = null;
MvtStock mvt= null;
MvtStock mvtE= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
String idEmprunt= null;
LettrageMvt[] letMvt =  null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
     idEmprunt = request.getParameter("idEmprunt");
mvt=u.findMvtStock(id,"","","%","%")[0];
mvtE =u.findMvtStock(idEmprunt,"","","%","%")[0];
ut = u.findTypeObjet("unitMvt","%","%");
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
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Emprunt </h1>
<h2>Mouvement source</h2>

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
   <td valign="top" class="left">Valeur d&eacute;bit&eacute;e : </td>
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
 <div align="center">

      <input type="hidden" value="INSERT" name="acte">

    <p>

    </p>
  </div>

<h2>Retour </h2>

<form name="form1" method="post" action="<%=lien%>?but=stock/apresRetourEmpruntReglement.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>


	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
	 <tr>
          <td  valign="top" class="left">Tiers :</td>
          <td  valign="top">&nbsp;<%=mvtE.getCompte()%> a mettre libelle </td>
        </tr>
	<tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10"> <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>

          </td>
        </tr>
	<tr>
          <td height="23" valign="top" class="left">Designation
            :</td>
          <td valign="top">&nbsp; <input name="designation" type="text" class="champ" id="designation" value="" size="10" maxlength="10"></td>
        </tr>


        <tr>
          <td valign="top" class="left">Valeur D&eacute;bit&eacute;e </td>
          <td valign="top"><p>
            <input type="text" name="valeur" value="<%=mvtE.getCredit()%>"/>
        unite <select name="unite">
<%
                                          for (int t=0;t<ut.length;t++){
                                                       %>
                                                          <option value="<%=ut[t].getTuppleID()%>" <%if(ut[t].getTuppleID().compareTo(mvtE.getUniteMvt())==0) out.println("selected");%>><%=ut[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select>	</td>
        </tr>

        <tr>
          <td valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp;<textarea name="noteExplicative" cols="40" rows="5"></textarea></td>
        </tr>
      </table></td>
  </tr>
</table>

  <div align="center">

      <input type="hidden" value="finalise" name="acte">

    <p>
      <input type="submit" class="submit" value="Régler l'emprunt">
    </p>
  </div>
</form>
<script language="JavaScript">
<!--dateParution
    var cal1 = new calendar1(document.all.date);
     cal1.year_scroll = false;
     cal1.time_comp = false;


     //-->
</script>