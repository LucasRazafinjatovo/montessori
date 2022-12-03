<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        UserEJB u = null;
        Societe spat = null;
        String id=null;
        TypeObjet enti[] =null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
spat = u.findMaSociete(id,"%","%","%","%","%","%","%","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Modifier information SPAT</h1>
 <form action="<%=lien%>?but=apresInfoSpat.jsp" method="post">
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="formadd">
    <tr>
      <td valign="top">
<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr><td width="47%">

<table width="100%" height="100%" border="0" align="center" cellpadding="3" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
            <td width="124" height="23" valign="top" class="left">Nom :</td>
                  <td width="150" align="center" valign="top">
<input name="nom" type="text" class="champ" id="nom" value="<%=spat.getNom()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">R&eacute;gime :</td>
                  <td align="center" valign="top">
<input name="regime" type="text" class="champ" id="regime" value="<%=spat.getRegime()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Mail :</td>
                  <td align="center" valign="top">
<input name="mail" type="text" class="champ" id="mail" value="<%=spat.getEMail()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">G&eacute;rant :</td>
                  <td align="center" valign="top">
<input name="ger" type="text" class="champ" id="ger" value="<%=spat.getGerant()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Logo :</td>
                  <td align="center" valign="top">
<input name="logo" type="text" class="champ" id="logo" value="<%=spat.getLogo()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Capital :</td>
                  <td align="center" valign="top">
<input name="capital" type="text" class="champ" id="capital" value="<%=spat.getCapital()%>">
                  </td>
          </tr>
          <tr>
                  <td height="23" valign="top" class="left">Num. compte 1 :</td>
                  <td align="center" valign="top">
<input name="banque1" type="text" class="champ" id="banque1" value="<%=spat.getBanque1()%>">
                  </td>
          </tr>
          <tr>
                  <td height="23" valign="top" class="left">Num. compte 2 :</td>
                  <td align="center" valign="top">
<input name="banque2" type="text" class="champ" id="banque2" value="<%=spat.getBanque2()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">T&eacute;l&eacute;phone
              :</td>
                  <td align="center" valign="top">
<input name="phone" type="text" class="champ" id="phone" value="<%=spat.getTelephone()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Fax :</td>
                  <td align="center" valign="top">
<input name="fax" type="text" class="champ" value="<%=spat.getFax()%>">
                  </td>
          </tr>

        </table></td>
      <td width="53%" valign="top">
        <table width="100%" height="100%" border="0" align="center" cellpadding="3" cellspacing="0">
                <tr>
            <td width="48%" height="23" valign="top" class="left">Adresse :</td>
                  <td width="52%" align="center" valign="top">
<textarea name="adr" rows="5" class="champ" id="adr"><%=spat.getAdresse()%></textarea>
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Num&eacute;ro statistique
              :</td>
                  <td align="center" valign="top">
<input name="stat" type="text" class="champ" id="numStat2" value="<%=spat.getNumStat()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">NIF :</td>
                  <td align="center" valign="top">
<input name="nif" type="text" class="champ" id="nif" value="<%=spat.getNif()%>">
                  </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">RC n&deg; :</td>
                  <td align="center" valign="top">
<input name="rc" type="text" class="champ" id="rc" value="<%=spat.getRc()%>">
                  </td>
          </tr>
          <tr>
                  <td height="23" valign="top" class="left">Taxe prof. :</td>
                  <td align="center" valign="top" >
<input name="tp" type="text" class="champ" id="tp2" size="18" value="<%=spat.getTp()%>">
                  </td>
          </tr>
          <tr>
                  <td height="66" valign="top" class="left">Quittance n&deg; :</td>
                  <td align="center" valign="top" >
<input name="quittance" type="text" class="champ" id="quittance" value="<%=spat.getQuittance()%>" size="18">
                    <br>
                    <input name="acte" type="hidden" id="acte3" value="UPDATE"> <input name="idSoc" type="hidden" id="idSoc" value="<%=spat.getIdSpat()%>"></td>
          </tr>
          <tr>
            <td height="23" class="left"> Entité :</td>
            <td> <select name="entite" class="champ" id="entite">
                <%
for(int i=0;i<enti.length;i++){
%>
                <option value="<%=enti[i].getId()%>" <%if(enti[i].getId().compareTo(spat.getEntite())==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                <%
}
%>
              </select></td>
          </tr>
		  </table>
		  </td></tr></table>
		</td>
    </tr>
<tr>
    <td height="30" align="center" colspan="2">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input type="submit" name="Submit" value="Valider" class="submit" onClick="MM_validateForm('nom','','R','phone','','R','mail','','R','adr','','R');return document.MM_returnValue">
          </td>
          <td align="center">
<input type="reset" name="Submit2" value="Annuler" class="submit">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>


		 </form>