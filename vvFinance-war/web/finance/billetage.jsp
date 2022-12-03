<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  user.UserEJB u=null;
  String lien;
  String dix, cinq, deux, un, deuxCinq, deuxCent, cent, cinquante, vingt;
  int montantAr=0;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
if ((request.getParameter("50")==null)||request.getParameter("50").compareTo("")==0)
  dix="0";
  else
    dix=request.getParameter("50");
if ((request.getParameter("25")==null)||request.getParameter("25").compareTo("")==0)
  cinq="0";
  else
    cinq=request.getParameter("25");
if ((request.getParameter("10")==null)||request.getParameter("10").compareTo("")==0)
  deux="0";
  else
    deux=request.getParameter("10");
if ((request.getParameter("5")==null)||request.getParameter("5").compareTo("")==0)
  un="0";
  else
    un=request.getParameter("5");
if ((request.getParameter("2")==null)||request.getParameter("2").compareTo("")==0)
  deuxCinq="0";
  else
    deuxCinq=request.getParameter("2");
if ((request.getParameter("1")==null)||request.getParameter("1").compareTo("")==0)
  deuxCent="0";
  else
    deuxCent=request.getParameter("1");
if ((request.getParameter("05")==null)||request.getParameter("05").compareTo("")==0)
  cent="0";
  else
    cent=request.getParameter("05");
if ((request.getParameter("02")==null)||request.getParameter("02").compareTo("")==0)
  cinquante="0";
  else
    cinquante=request.getParameter("02");
if ((request.getParameter("01")==null)||request.getParameter("01").compareTo("")==0)
  vingt="0";
  else
    vingt=request.getParameter("01");
montantAr=u.getMontantBilletage(dix, cinq, deux, un, deuxCinq, deuxCent, cent, cinquante, vingt);
%>
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<p class="titre">&nbsp;</p>
<h1>Billetage</h1>
<form action="<%=lien%>?but=finance/billetage.jsp" method="post" target="_parent">
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
            <td width="184" height="22" class="tete-tableau"><div align="right">10
                000 Ar</div></td>
            <td width="276"><div align="center">
                <input name="50" type="text" class="champSaisie" id="50" value="<%=dix%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">5 000 Ar</div></td>
            <td><div align="center">
                <input name="25" type="text" class="champSaisie" id="designation3" value="<%=cinq%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">2 000 Ar</div></td>
            <td><div align="center">
                <input name="10" type="text" class="champSaisie" id="daty23" value="<%=deux%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">1 000 Ar</div></td>
            <td><div align="center">
                <input name="5" type="text" class="champSaisie" id="remarque" value="<%=un%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">500 Ar</div></td>
            <td><div align="center">
                <input name="2" type="text" class="champSaisie" id="piece" value="<%=deuxCinq%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">200 Ar</div></td>
            <td><div align="center">
                <input name="1" type="text" class="champSaisie" id="piece" value="<%=deuxCent%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">100 Ar</div></td>
            <td><div align="center">
                <input name="05" type="text" class="champSaisie" id="piece" value="<%=cent%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">50 Ar</div></td>
            <td><div align="center">
                <input name="02" type="text" class="champSaisie" id="piece" value="<%=cinquante%>">
              </div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right">20 Ar</div></td>
            <td><div align="center">
                <input name="01" type="text" class="champSaisie" id="piece" value="<%=vingt%>">
              </div></td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td><table width="100%" height="52" border="0" cellpadding="0">
          <tr>
          <td><div align="center">
                <input name="Submit" type="submit" class="boutons" value="Calculer">
              </div></td>
          <td><div align="center">
              <input name="Submit2" type="reset" class="boutons" value="Annuler">
            </div></td>
        </tr>
      </table></td>
  </tr>
</table><br><br>
  <table width="350" border="0" align="center" class="monographe">
    <tr>
      <td width="184" class="tete-tableau"><div align="right">Valeur en Ar</div></td>
      <td><div align="center"><%=Utilitaire.formaterAr(String.valueOf(montantAr))%> Ar</div></td>
    </tr>
    <tr>
      <td class="tete-tableau"><div align="right">Valeur en Fmg</div></td>
      <td><div align="center"><%=Utilitaire.formaterAr(String.valueOf(montantAr*5))%> Fmg</div></td>
    </tr>
  </table>
</form></body>
</html>
