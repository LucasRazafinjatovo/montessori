<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="stock/apresSaisieStandard.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet op[] = null;
   TypeObjet ut[] = null;
    TypeObjet compte[] = null;
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
op = u.findTypeObjet("typeMvt","%","%");
ut = u.findTypeObjet("unitMvt","%","%");
compte= u.findTypeObjet("compte","%","%");
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
<h1>Saisie standard </h1>

<form name="form2" method="post" action="<%=lien%>?but=<%=apres%>">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
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
          <td  height="23" valign="top" class="left">Type</td>
          <td valign="top">&nbsp; <select name="type">
<%
                                          for (int t=0;t<op.length;t++){
                                                       %>
                                                          <option value="<%=op[t].getTuppleID()%>"><%=op[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select>

   </td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Compte </td>
          <td valign="top">&nbsp; <select name="compte">
<%
                                          for (int t=0;t<compte.length;t++){
                                                       %>
                                                          <option value="<%=compte[t].getTuppleID()%>"><%=compte[t].getVal()%> </option>
                                                       <%
                                          }
                                                       %>
</select>           </td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Debit </td>
          <td valign="top">&nbsp; <input name="debit" type="text" class="champ" id="debit" value="" size="10" maxlength="10">		  </td>
        </tr>
		 <tr>
          <td  height="23" valign="top" class="left">credit </td>
          <td valign="top">&nbsp; <input name="credit" type="text" class="champ" id="credit" value="" size="10" maxlength="10">		  </td>
        </tr>

		 <tr>
          <td  height="23" valign="top" class="left">Unité</td>
          <td valign="top">&nbsp; <select name="unite">
<%
                                          for (int t=0;t<ut.length;t++){
                                                       %>
                                                          <option value="<%=ut[t].getTuppleID()%>"><%=ut[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select>		  </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque :</td>
          <td valign="top">&nbsp; <textarea name="noteExplicative" cols="40" rows="5"></textarea></td>
        </tr>
      </table></td>
  </tr>
</table>


  <div align="center">



    <p>
      <input type="submit"  class="submit" value="Enregistrer"><input type="reset" class="submit" value="Retablir"><input type="button" class="submit" value="Annuler">
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

