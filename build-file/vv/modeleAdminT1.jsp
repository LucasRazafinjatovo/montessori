<%@ page import="utilitaire.*" %>
<%!
	String but="index.jsp";
    String lien="modele.jsp";
%>
<%
	if (session.getValue("lien")!=null)
			lien=(String)session.getValue("lien");
	if((request.getParameter("but")!=null)&&session.getValue("u")!=null)
        {
		but=request.getParameter("but");
                lien=(String)session.getValue("lien");
        }
	else
        {
		but="index.jsp";
        }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Gestion des recettes</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css">
<script src="calendar/calendar1.js"></script>
<SCRIPT language="JavaScript" src="script.js"></script>
</head>
<body>
<table width="800" border="0" align="center" cellspacing="0">
  <tr> </tr>
  <tr> 
    <td colspan="3" bgcolor="#ADADAD"><img src="images/ban-1.jpg"></td>
  </tr>
  <tr> 
    <td colspan="2" bgcolor="#D7D7D7">&nbsp;</td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td height="10" bgcolor="#D7D7D7"></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td width="19%" height="10" bgcolor="#D7D7D7"> <table border="0" cellpadding="0" cellspacing="0" width="160">
        <!-- fwtable fwsrc="Sans titre" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
        <tr> 
          <td><img src="spacer.gif" width="160" height="1" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr> 
          <td background="menu/menu_r1_c1.gif" align="center"><font color="#FFFFFF"><strong>Facture</strong></font></td>
          <td><img src="spacer.gif" width="1" height="19" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/entree.jsp" class="menu">Enregistrer</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/entreeFournisseur.jsp"" class="menu">Lister 
            Fournisseurs </a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img name="menu_r3_c1" src="menu/menu_r3_c1.gif" width="160" height="7" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="7" border="0" alt=""></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td height="10" bgcolor="#D7D7D7"></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td width="19%" height="10" bgcolor="#D7D7D7"> <table border="0" cellpadding="0" cellspacing="0" width="160">
        <!-- fwtable fwsrc="Sans titre" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
        <tr> 
          <td><img src="spacer.gif" width="160" height="1" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr> 
          <td background="menu/menu_r1_c1.gif" align="center"><font color="#FFFFFF"><strong>Recettes</strong></font></td>
          <td><img src="spacer.gif" width="1" height="19" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/entree.jsp" class="menu">Enregistrer</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereEntree.jsp" class="menu">Lister 
            Recettes</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereCroiseEntree.jsp" class="menu">Recherche 
            croisée</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img name="menu_r3_c1" src="menu/menu_r3_c1.gif" width="160" height="7" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="7" border="0" alt=""></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td height="10" bgcolor="#D7D7D7"></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td width="19%" height="10" bgcolor="#D7D7D7"> <table border="0" cellpadding="0" cellspacing="0" width="160">
        <!-- fwtable fwsrc="Sans titre" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
        <tr> 
          <td><img src="spacer.gif" width="160" height="1" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr> 
          <td background="menu/menu_r1_c1.gif" align="center"><font color="#FFFFFF"><strong>D&eacute;penses</strong></font></td>
          <td><img src="spacer.gif" width="1" height="19" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/sortie.jsp" class="menu">Enregistrer</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereSortie.jsp" class="menu">Lister 
            Dépenses</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereCroiseSortie.jsp" class="menu">Recherche 
            crois&eacute;e </a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img name="menu_r3_c1" src="menu/menu_r3_c1.gif" width="160" height="7" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="7" border="0" alt=""></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td height="10" bgcolor="#D7D7D7"></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td width="19%" height="10" bgcolor="#D7D7D7"> <table border="0" cellpadding="0" cellspacing="0" width="160">
        <!-- fwtable fwsrc="Sans titre" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
        <tr> 
          <td><img src="spacer.gif" width="160" height="1" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr> 
          <td background="menu/menu_r1_c1.gif" align="center"><font color="#FFFFFF"><strong>Caisse</strong></font></td>
          <td><img src="spacer.gif" width="1" height="19" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/caisse.jsp" class="menu">Enregistrer</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCaisse.jsp" class="menu">Lister 
                  caisse</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img name="menu_r3_c1" src="menu/menu_r3_c1.gif" width="160" height="7" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="7" border="0" alt=""></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td height="10" bgcolor="#D7D7D7"></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td width="19%" height="10" bgcolor="#D7D7D7"> <table border="0" cellpadding="0" cellspacing="0" width="160">
        <!-- fwtable fwsrc="Sans titre" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
        <tr> 
          <td><img src="spacer.gif" width="160" height="1" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="1" border="0" alt=""></td>
        </tr>
        <tr> 
          <td background="menu/menu_r1_c1.gif" align="center"><font color="#FFFFFF"><strong>Utilisateurs</strong></font></td>
          <td><img src="spacer.gif" width="1" height="19" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/utilisateur.jsp" class="menu">Enregistrer</a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/listeUtilisateur.jsp" class="menu">Lister 
                  </a></td>
          <td><img src="spacer.gif" width="1" height="24" border="0" alt=""></td>
        </tr>
        <tr> 
          <td><img name="menu_r3_c1" src="menu/menu_r3_c1.gif" width="160" height="7" border="0" alt=""></td>
          <td><img src="spacer.gif" width="1" height="7" border="0" alt=""></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td bgcolor="#D7D7D7">&nbsp;</td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td bgcolor="#D7D7D7">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="#D7D7D7">&nbsp;</td>
    <td bgcolor="#D7D7D7">&nbsp;</td>
  </tr>
  <tr> 
    <td width="1%" bgcolor="#D7D7D7">&nbsp;</td>
    <td bgcolor="#D7D7D7"><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer 
        session </a></div></td>
    <td width="80%" bgcolor="#D7D7D7"><div align="center"></div></td>
  </tr>
</table>
<link href="style/style.css" rel="stylesheet" type="text/css"></td>
<td align="center" valign="top" background="images/bg_m.gif">&nbsp; </td>
  </tr>
  <tr> 
    <td bgcolor="#0099FF">&nbsp;</td>
    <td bgcolor="#0099FF"><div align="center">dfdf</div></td>
</tr>
</body>
</html>
