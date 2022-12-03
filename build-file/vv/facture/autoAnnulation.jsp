<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresAutoAnnulation.jsp";
	String lien= null;
        TypeObjet to[] = null;
        UserEJB u = null;
        String numObjet=null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//numObjet=request.getParameter("numObjet");
to = u.findTypeObjet("TypeObjet","%","%");
//scatsvc = u.findSCatService(idScatService,"%","%","%")[0];
}catch(Exception e){
%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;er une autorisation d'annulation</h1>

<table width="448" align="center" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td width="444" height="19" valign="top" class="remarque">Une autorisation 
      d'annulation est obligatoire avant d'annuler un objet.</td>
  </tr>
</table>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="autoAnnul">
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center"><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td width="38%" class="left">Date :</td>
          <td width="8%">&nbsp;</td>
          <td width="54%"><input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10"> 
            <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a> 
          </td>
        </tr>
        <tr>
            <td class="left">Type objet : </td>
          <td>&nbsp;</td>
          <td><select name="idTypeObjet" class="champ" id="select">
              <%
for(int i=0;i<to.length;i++){
%>
              <option value="<%=to[i].getId()%>"><%=to[i].getVal()%></option>
              <%
}
%>
            </select></td>
        </tr>
        <tr>
            <td class="left">Num&eacute;ro objet &agrave; annuler : </td>
          <td>&nbsp;</td>
          <td><input name="num" type="text" class="champ" id="num2"></td>
        </tr>
        <tr>
            <td class="left">Responsable : </td>
          <td>&nbsp;</td>
          <td><input name="responsable" type="text" class="champ" id="responsable2" value="-"></td>
        </tr>
        <tr>
            <td valign="top" class="left">Motif :</td>
          <td>&nbsp;</td>
          <td><textarea name="motif" cols="30" class="champ" id="textarea">-
</textarea>
            <input name="acte" type="hidden" id="acte3" value="INSERT"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30" align="center"> 
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">
<input type="submit" name="Submit" value="Enregistrer" class="submit">
            </td>
            <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
        </tr>
      </table>
      </td>
  </tr>
</table>



</form>
<table width="432" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="432" height="48" valign="top" class="remarque">(*) Remplir les 
      informations relatives a l'annulation.</td>
    </tr>
</table>
<script language="javascript">
var cal1 = new calendar1(document.forms['autoAnnul'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>