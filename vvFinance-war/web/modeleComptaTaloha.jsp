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
<title>Gestion des recettes : SPAT / TAC</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css">
<script src="calendar/calendar1.js"></script>
<SCRIPT language="JavaScript" src="script.js"></script>
</head>
<body>
<link href="style/style.css" rel="stylesheet" type="text/css">
<table width="800" border="0" align="center" cellspacing="0">
  <tr>
    <td colspan="2" bgcolor="#C300FF">
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#C300FF" align="center">
        <!--DWLayoutTable-->
        <tr>
          <td bgcolor="#C300FF"><img src="images/bateau1.jpg" width="179" height="99"></td>
          <td width="330" height="100" align="center" valign="middle" bgcolor="#C300FF" class="titre">
            <img src="images/banner.gif" width="320" height="75"> </td>
          <td width="251"><img src="images/bateau.jpg" width="251" height="99"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="20%" valign="top"  bgcolor="#C300FF">
      <table width="100%" border="0" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp; </td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp; </td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Recettes</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/entree.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/critereEntree.jsp" class="menu">Lister</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/typeEntree.jsp" class="menu">Enr.
                        type de recette</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/listeTypeEntree.jsp" class="menu">Liste
                        type de recette</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/critereEtatFacture.jsp" class="menu">Analyser
                        par facture</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/billetage.jsp" class="menu">Billetage</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/convertirMonnaie.jsp" class="menu">Convertir</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">D&eacute;penses</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/sortie.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/critereSortie.jsp" class="menu">Lister</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/typeSortie.jsp" class="menu">Enr.
                        type de d&eacute;p.</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/listeTypeSortie.jsp" class="menu">Liste
                        type de d&eacute;p.</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/reporter.jsp" class="menu">Reporter</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/virer.jsp" class="menu">Virement</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/beneficiaire.jsp" class="menu">Enregistrer
                        b&eacute;n.</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/listeBeneficiaire.jsp" class="menu">Lister
                        b&eacute;n&eacute;ficiaire </a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Param&egrave;tre</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=facture/listeDevise.jsp" class="menu">Lister
                        devise</a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Caisse</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/tableauBord.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Tableau
                        de bord</a></tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCaisse.jsp" class="menu">Lister
                        caisse</a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Admin
                  Facture</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeParamFacture.jsp" class="menu">Afficher
                        Parametre</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeTva.jsp" class="menu">Afficher
                        tva</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeEcriture.jsp" class="menu">Lister
                        Ecritures </a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeAvoir.jsp" class="menu">Lister
                        avoir</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeCompte.jsp" class="menu">Lister
                        Comptes </a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Autres</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=listeInfoSpat.jsp" class="menu">Aff.
                        Info. VV</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Change</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeChange.jsp" class="menu">Histo.
                        change </a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Utilisateur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/detailUtilisateurPerso.jsp" class="menu">Mes
                        infos perso.</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" heightA="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Aide</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="aide/ManuelUtilisateurFinance.htm" class="menu">Finance</a></td>
                    </tr>
                    <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeHistoriqueFacture.jsp" class="menu">Lister
                        historique </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>-->
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td bgcolor="#C300FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#C300FF">&nbsp;</td>
          <td bgcolor="#C300FF"><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
              session </a></div></td>
          <td width="6%" bgcolor="#C300FF">&nbsp;</td>
        </tr>
      </table>
    </td>
    <td align="center" valign="top" background="images/bg_m.gif">
      <table width="100%" height="100%" border="0">
        <tr>
          <td><span class="modele">:: Comptabilit&eacute;</span></td>
        </tr>
        <tr>
          <td align="center"><br>
<jsp:include page='<%=but %>'/></td>
        </tr>
      </table>
	  <br>
    </td>
  </tr>
  <tr>
    <td bgcolor="#C300FF">&nbsp;</td>
    <td bgcolor="#C300FF"><div align="center"><span class="copy">&copy; JREWS
        Informatika</span> <span class="copy"> - Octobre 2005</span> </div></td>
  </tr>
</table>
</body>
</html>
