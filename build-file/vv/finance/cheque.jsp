<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.MvtCaisse" %>
<%@ page import="finance.Caisse" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  user.UserEJB u=null;
  String lien;
  String idMvt=null;
  int montantAr=0;
  MvtCaisse mvt=null;
  Caisse caiss[] = null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
idMvt=request.getParameter("idMvt");
caiss = u.findCaisse("%","%","%","%");
mvt=u.findMvtCaisse(idMvt, "", "", "", "", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
%>
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<p class="titre">&nbsp;</p>
<h1>Saisie ch&egrave;que</h1>
<form action="<%=lien%>?but=finance/apresCheque.jsp" method="post" target="_parent">
  <table width="350" border="0" align="center" cellpadding="0">
    <tr>
    <td class="titre">     <br>
        <input name="acte" type="hidden" id="acte" value="INSERT"></td>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td width="184" height="22" class="tete-tableau"><div align="right"><strong>id Mvt </strong></div></td>
            <td width="276"><div align="center">
                <input name="idMvt" type="text" class="champSaisie" id="idMvt" value="<%=idMvt%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>date saisie </strong></div></td>
            <td><div align="center">
                <input name="datyS" type="text" class="champSaisie" id="designation3" value="<%=Utilitaire.dateDuJour()%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>date Valeur</strong></div></td>
            <td><div align="center">
                <input name="datyV" type="text" class="champSaisie" id="daty23" value="<%=Utilitaire.dateDuJour()%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>ordre</strong></div></td>
            <td><div align="center">
                <input name="ordre" type="text" class="champSaisie" id="remarque">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>remarque</strong></div></td>
            <td><div align="center">
                <input name="rem" type="text" class="champSaisie" id="piece">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>numero ch&egrave;que </strong></div></td>
            <td><div align="center">
                <input name="numCheque" type="text" class="champSaisie" id="piece">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>caisse</strong></div></td>
            <td><div align="center">
                <select name="caisse" class="champ" id="idCaisse">

                <%
for(int i=0;i<caiss.length;i++){

%>
                <option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select>
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>montant</strong></div></td>
            <td><div align="center">
                <input name="montant" type="text" class="champSaisie" id="piece" value="<%=mvt.getDebit() %>">
              </div></td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td><table width="100%" height="52" border="0" cellpadding="0">
          <tr>
          <td width="54%"><div align="center">
                <input name="Submit" type="submit" class="boutons" value="Valider">
              </div></td>
          <td width="46%"><div align="center">
              <input name="Submit2" type="reset" class="boutons" value="Annuler">
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
</form></body>
</html>
