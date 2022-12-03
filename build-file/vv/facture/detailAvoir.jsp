<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        UserEJB u = null;
	facture.Avoir temp[]=null;
	facture.Avoir av=null;
        String lien = null;
	String a = null;
        facture.FactMere fm = null;
%>
<%
a =request.getParameter("a");
if(a==null)a="";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
                 //String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ
temp=u.findAvoir(request.getParameter("idAvoir"),"%","%","","","%","%");
if (temp.length<=0) throw new Exception("Avoir non existant");
av=temp[0];
fm= u.findFactureMere("","",av.getIdFactureMere(),"%","","%","%","%")[0];

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<title>Aper&ccedil;u avoir</title><h1>Avoir N&deg; <%=av.getIdAvoir()%></h1>
<table cellspacing="0" cellpadding="0" align="center" width="445">
<tr><td width="441">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td width="186" height="35" class="left">
<div align="right">Date :</div></td>
          <td width="245"><div align="center"><%=Utilitaire.formatterDaty(av.getDaty())%></div></td>
        </tr>
        <tr>
          <td class="left" height="38">
<div align="right">Facture Num:</div></td>
          <td><div align="center"><a href="<%=lien%>?idFactureMere=<%=av.getIdFactureMere()%>&but=facture/detailFacture.jsp"><%=av.getIdFactureMere()%></a></div></td>
        </tr>
        <tr>
          <td class="left" height="36">
<div align="right">Montant : </div></td>
          <td><div align="center"><%=Utilitaire.formaterAr((double)av.getMontant())%> <%=u.findTypeObjet("Devise",fm.getIdFactureEn(),"%")[0].getVal()%></div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Motif : </div></td>
          <td><div align="center"><%=av.getMotif()%></div></td>
        </tr>
        <tr>
          <td class="left" height="37">
<div align="right">Autoris&eacute; par :</div></td>
          <td><div align="center"><%=av.getResponsable()%></div></td>
        </tr>
        <tr>
          <td class="left" height="42">
<div align="right">Type Avoir :</div></td>
          <td><div align="center"><%=av.getType()%></div></td>
        </tr>
        <tr>
          <td class="left" height="40">
<div align="right">id Avoir :</div></td>
          <td><div align="center"><%=av.getTuppleID()%></div></td>
        </tr>
      </table>

</td>
</tr>
</table>
 <%
if(a.compareTo("yes")!=0){
%>
<div align="center"><br>
  <br>
  <!--<a href="facture/detailAvoir.jsp?idAvoir=<%=av.getIdAvoir()%>&a=yes" target="_blank">Voir aper&ccedil;u</a></div>-->
  <a href='javascript:Popup("facture/detailAvoir.jsp?idAvoir=<%=av.getIdAvoir()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>

<%
}
%>