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

<form name="form2" method="post" action="<%=lien%>?but=stock/apresSasieParution.jsp">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date opération:</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" class="champ" id="date" value="" size="10" maxlength="10">
<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
   </td>
        </tr>
		 <tr>
          <td width="144" height="23" valign="top" class="left">Date parution:</td>
          <td width="254" valign="top">&nbsp; <input name="dateParution" type="text" class="champ" id="dateParution" value="" size="10" maxlength="10">
<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>

      </td>
        </tr>
        <tr>
          <td width="144" height="23" valign="top" class="left">Journal
            :</td>
          <td width="254" valign="top">&nbsp; <select name="journal">
 <%
                                          for (int t=0;t<jrnl.length;t++){
                                                       %>
                                                          <option value="<%=jrnl[t].getTuppleID()%>"><%=jrnl[t].getVal()%> </option>
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
          <td width="254" valign="top">&nbsp; <select name="printer">
<%
                                          for (int t=0;t<prt.length;t++){
                                                       %>
                                                          <option value="<%=prt[t].getTuppleID()%>"><%=prt[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>

</select></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="remarque" cols="40" rows="5"></textarea></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Designation mouvement :</td>
          <td valign="top"> &nbsp;<input name="designation" type="text" class="champ" value=""></td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Magasin</td>
          <td valign="top"><select name="magasin">
<%
                                          for (int t=0;t<mg.length;t++){
                                                       %>
                                                          <option value="<%=mg[t].getTuppleID()%>"><%=mg[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>
</select>		  </td>
        </tr>
      </table></td>
  </tr>
</table>


  <div align="center">

      <input type="hidden" value="finalise" name="acte">

    <p>
      <input type="button" class="submit" value="Enregistrer">
    </p>
  </div>
</form>

<script language="JavaScript">
<!--dateParution
    var cal1 = new calendar1(document.all.date);
     cal1.year_scroll = false;
     cal1.time_comp = false;

     var cal2 = new calendar1(document.all.dateParution);
     cal2.year_scroll = false;
     cal2.time_comp = false;
     //-->
</script>


