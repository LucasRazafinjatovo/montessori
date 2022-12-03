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

TypeObjet compteMag[] = null;
TypeObjet compteTiers[] = null;
TypeObjet mg[] = null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
  TypeObjet ut[] = null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");

     compteTiers = u.findTypeObjet("compte","%","%");
    compteMag= u.findTypeObjet("compte","%","%");
    mg= u.findTypeObjet("compte","%","%");
     /**/
 ut = u.findTypeObjet("unitMvt","%","%");
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
<h1>Saisie d'un livraison</h1>

<form name="form2" method="post" action="<%=lien%>?but=stock/apresSaisieLivraison.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
<input type="hidden" name="acte" value="INSERT">
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
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
          <td  height="23" valign="top" class="left">Valeur</td>
          <td valign="top">&nbsp; <input name="valeur" type="text" class="champ" id="valeur" value="" size="10" maxlength="10">
		  unite

                 <select name="unite">
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
          <td  height="23" valign="top" class="left">Magasin</td>
          <td valign="top">&nbsp; <select name="magasin">
<%
                                          for (int t=0;t<compteMag.length;t++){
                                                       %>
                                                          <option value="<%=compteMag[t].getTuppleID()%>"><%=compteMag[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>
</select>     
		  </td>
        </tr>
		<tr>
          <td  height="23" valign="top" class="left">Fournisseur</td>
          <td valign="top">&nbsp;<select name="tiers">
<%
                                          for (int t=0;t<compteTiers.length;t++){
                                                       %>
                                                          <option value="<%=compteTiers[t].getTuppleID()%>"><%=compteTiers[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>
</select>   
		  </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="noteExplicative" cols="40" rows="5"></textarea></td>
        </tr>

      </table></td>
  </tr>
</table>


  <div align="center">

      <input type="hidden" value="finalise" name="acte">
	    <input type="hidden" value="vivraison" name="tm">

    <p>
      <input type="submit" class="submit" value="Enregistrer"><input type="reset" class="submit" value="Retablir"><input type="button" class="submit" value="Annuler">
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
