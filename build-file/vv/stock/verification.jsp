<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="stock/apresVerification.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet mg[] = null;
MvtStock mvt= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
LettrageMvt[] letMvt =  null;
  TypeObjet ut[] = null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
 mg = u.findTypeObjet("compte","%","%");
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
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Vérification</h1>

<form name="form2" method="post" action="<%=lien%>?but=<%=apres%>">
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
        <tr>
          <td width="144" height="23" valign="top" class="left">Date :</td>
          <td width="254" valign="top">&nbsp; <input name="date" type="text" disabled class="champ" id="date" value="" size="10" maxlength="10"> <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
    </td>
        </tr><tr>
          <td  height="23" valign="top" class="left">Magasin : </td>
          <td valign="top">&nbsp; <select name="magasin">
 <%
                                for(int i=0;i<mg.length;i++){
                                %>
                <option value="<%=mg[i].getId()%>"><%=mg[i].getVal()%></option>
                <%
                                 }
                                %>
</select>		  </td>
        </tr>
        <tr>
          <td  height="23" valign="top" class="left">Reste</td>
          <td valign="top">&nbsp; <input name="reste" type="text" disabled class="champ" id="reste" value="" size="10" maxlength="10">	  </td>
        </tr>

        <tr>
          <td height="23" valign="top" class="left">Unit&eacute;</td>
          <td valign="top">&nbsp;  <select name="unite">
<%
                                          for (int t=0;t<ut.length;t++){
                                                       %>
                                                          <option value="<%=ut[t].getTuppleID()%>"><%=ut[t].getVal()%></option>
                                                       <%
                                          }
                                                       %>
</select></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Controleur</td>
          <td valign="top"> &nbsp;<input name="controleur" type="text" disabled class="champ" id="controleur" value="" size="10" maxlength="10"></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Remarque</td>
          <td valign="top"> &nbsp;<textarea name="remarque" cols="40" rows="5"></textarea></td>
        </tr>
      </table></td>
  </tr>
</table>


  <div align="center">

      <input type="hidden" value="finalise" name="acte">

    <p>
      <input type="button" class="submit" value="Enregister">
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