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
<table border="0" align="center" cellspacing="0">
  <tr>
    <td colspan="2" bgcolor="#0099FF">
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#0099FF" align="center">
        <!--DWLayoutTable-->
        <tr>
          <td bgcolor="#0099FF"><img src="images/bateau1.jpg" width="179" height="99"></td>
          <td width="330" height="100" align="center" valign="middle" bgcolor="#0099FF" class="titre">
            <img src="images/banner.gif" width="320" height="75"> </td>
          <td width="251"><img src="images/bateau.jpg" width="251" height="99"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="158" valign="top"  bgcolor="#0099FF">
      <table width="100%" border="0" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp; </td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td height="10" bgcolor="#0099FF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Ed&deg; 
                  / An. Facture</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; 
                        <a href="<%=lien%>?but=facture/factureInit.jsp" class="menu">Nouvelle</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFactureAnalyse.jsp" class="menu">Analyser 
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFacture.jsp" class="menu">Lister 
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeHistoriqueFacture.jsp" class="menu">Lister
                        historique </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>-->
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/client.jsp" class="menu">Enregistrer 
                        client</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeClient.jsp" class="menu">Lister 
                        client </a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/traficEvp.jsp" class="menu">Ajout 
                        trafic (TAC)</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereTraficEvp.jsp" class="menu">Lister 
                        trafic (TAC)</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td width="91%" height="10" bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Admin
                  Facture</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/paramFacture.jsp" class="menu">Modifier 
                        Parametre</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeParamFacture.jsp" class="menu">Afficher 
                        Parametre</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/tva.jsp" class="menu">Modifier 
                        tva</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeTva.jsp" class="menu">Afficher 
                        tva</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereEcriture.jsp" class="menu">Lister 
                        Ecritures </a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeCompte.jsp" class="menu">Lister 
                        Comptes</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/avoir.jsp" class="menu">Cr&eacute;er 
                        avoir </a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereAvoir.jsp" class="menu">Lister 
                        avoir</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeService.jsp" class="menu">Lister 
                        service</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; 
                        <a href="<%=lien%>?but=parametre/unite.jsp" class="menu">Enregistrer 
                        unit&eacute;</a> </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; 
                        <a href="<%=lien%>?but=parametre/listeUnite.jsp" class="menu">Lister 
                        unit&eacute;</a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>

         <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Auto.
                  annulation </td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/autoAnnulation.jsp" class="menu">Enregistrer</a> 
                      </td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereAutoAnnul.jsp" class="menu">Lister</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">P&eacute;nalit&eacute;s</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/verifPenalite.jsp" class="menu">V&eacute;rifier</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/criterePenalites.jsp" class="menu">Lister</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/accident.jsp">Enr. 
                        accident</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeAccident.jsp" class="menu">Lister 
                        accident </a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/volConteneur.jsp" class="menu">Enr. 
                        vol conteneur</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeVolConteneur.jsp" class="menu">Lister 
                        vol conteneur</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/dommageCont.jsp" class="menu">Enr. 
                        dom. cont.</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeDommCont.jsp" class="menu">Lister 
                        dom. cont.</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=parametre/chiffreAffaireTac.jsp" class="menu">Chiffre 
                        d'affaire TAC</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=parametre/listeChiffreAffaireTac.jsp" class="menu">Histo. 
                        ch. d'aff. TAC</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/criterePointage.jsp" class="menu">Synth&egrave;se 
                        pointage </a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td width="91%" bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Admin.
                  P&eacute;nalit&eacute;</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="#">Historique traffic</a> </td>
                    </tr>-->
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/paramPenalite.jsp" class="menu">Modifier 
                        Parametre</a></td>
                    </tr>
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Afficher 
                        Parametre</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Param&egrave;tre</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr> 
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/devise.jsp" class="menu">Enregistrer 
                        devise</a> </tr>
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
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
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
                        <a href="<%=lien%>?but=finance/convertMoney.jsp" class="menu">Convertir</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
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
                        <a href="<%=lien%>?but=finance/tableauBord.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Tableau
                        de bord</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Caisse</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/caisse.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCaisse.jsp" class="menu">Lister
                        </a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>


        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Change</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/change.jsp" class="menu">Mod. 
                        change</a></td>
                    </tr>
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
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
        </tr>
		 <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Autres</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=infoSpat.jsp" class="menu">Mod.
                        Info. SPAT</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=listeInfoSpat.jsp" class="menu">Aff. Info.
                        SPAT</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <!--DWLayoutTable-->
              <tr>
                <td height="3"></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td  width="15" height="25"> <img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Historique</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=historique/critereHistorique.jsp" class="menu">Lister</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
		 <tr>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
        </tr>
		 <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Utilisateur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/utilisateur.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/listeUtilisateur.jsp" class="menu">Lister
                        </a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%" bgcolor="#0099FF">&nbsp;</td>
          <td bgcolor="#0099FF"><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
              session </a></div></td>
          <td width="6%" bgcolor="#0099FF">&nbsp;</td>
        </tr>
      </table>
    </td>
    <td width="639" align="center" valign="top" background="images/bg_m.gif">
      <table width="100%" height="100%" border="0">
        <tr>
          <td><span class="modele">:: Administrateur du système</span> </td>
        </tr>
        <tr>
          <td align="center"><br>
</td>
        </tr>
      </table>

      <br>
      <table width="100%" border="0" align="center">
        <tr>
          <td><div align="center"></div>
            <jsp:include page='<%=but %>'/></td>
        </tr>
      </table> </td>
  </tr>
  <tr>
    <td bgcolor="#0099FF">&nbsp;</td>
    <td height="20" align="center" valign="middle" bgcolor="#0099FF"> 
      <div align="center"><span class="copy">&copy; JREWS Informatika - Octobre 
        2005</span> </div></td>
  </tr>
</table>
</body>
</html>
