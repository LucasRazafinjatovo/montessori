<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        UserEJB u = null;
        Societe spat = null;
        String id=null;
        bean.TypeObjet enti[]=null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
spat = u.findMaSociete(id,"%","%","%","%","%","%","%","%","%");
enti = u.findTypeObjet("BENEFICIAIRE",spat.getEntite(),"%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Information Soci&eacute;t&eacute;.</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="monographe">
    <td width="110" height="23" align="right" valign="top" class="left">Nom :</td>
    <td width="183" valign="top"><div align="center"><%=spat.getNom()%></div></td>
    <td width="89" height="23" align="right" valign="top" class="left">T&eacute;l&eacute;phone
      :</td>
    <td width="190" valign="top"><div align="center"><%=spat.getTelephone()%>&nbsp;</div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">R&eacute;gime :</td>
    <td valign="top"><div align="center"><%=spat.getRegime()%></div></td>
    <td height="23" align="right" valign="top" class="left">Fax :</td>
    <td valign="top"><div align="center"><%=spat.getFax()%></div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Mail :</td>
    <td valign="top"><div align="center"><%=spat.getEMail()%></div></td>
    <td height="23" align="right" valign="top" class="left">Adresse :</td>
    <td valign="top"><div align="center"><%=spat.getAdresse()%>&nbsp;</div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">G&eacute;rant :</td>
    <td valign="top"><div align="center"><%=spat.getGerant()%></div></td>
    <td height="23" align="right" valign="top" class="left">Num. stat. :</td>
    <td valign="top"><div align="center"><%=spat.getNumStat()%></div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Logo :</td>
    <td valign="top"><div align="center"><%=spat.getLogo()%>&nbsp;</div></td>
    <td height="23" align="right" valign="top" class="left">NIF :</td>
    <td valign="top"><div align="center"><%=spat.getNif()%></div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Capital :</td>
    <td valign="top"><div align="center"><%=spat.getCapital()%></div></td>
    <td height="23" align="right" valign="top" class="left">RC n&deg; :</td>
    <td valign="top"><div align="center"><%=spat.getRc()%></div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Num. compte 1 :</td>
    <td valign="top"><div align="center"><%=spat.getBanque1()%></div></td>
    <td height="23" align="right" valign="top" class="left">Taxe prof. :</td>
    <td valign="top" ><div align="center"><%=spat.getTp()%> </div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Num. compte 2 :</td>
    <td valign="top"><div align="center"><%=spat.getBanque2()%></div></td>
    <td height="23" align="right" valign="top" class="left">Quittance n&deg; :</td>
    <td valign="top" ><div align="center"><%=spat.getQuittance()%> </div></td>
  </tr>
  <tr class="monographe">
    <td height="23" align="right" valign="top" class="left">Entite :</td>
    <td valign="top"><div align="center"><%=enti[0].getDesce()%></div></td>
    <td height="23" align="right" valign="top" class="left"></td>
    <td valign="top" ></td>
  </tr>
</table>
</td></tr></table>
