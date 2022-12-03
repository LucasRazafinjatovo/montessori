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
<link href="style/style.css" rel="stylesheet" type="text/css">
<table width="1024" border="0" align="center" cellspacing="0">
  <tr>
    <td colspan="2" bgcolor="#C300FF"> <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#C300FF" align="center">
        <!--DWLayoutTable-->
        <tr>
          <td bgcolor="#364FA3"><img src="images/bateau.jpg" width="251" height="99"></td>
          <td width="330" height="100" align="center" valign="middle" bgcolor="#364FA3" class="titre">
            <img src="images/banner.gif" width="320" height="75"> </td>
          <td width="251" bgcolor="#364FA3"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="17%" valign="top"  bgcolor="#C300FF"> <table width="98%" border="0" cellspacing="0" bgcolor="#8CB0F8">
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td>&nbsp; </td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Facture fournisseur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp" class="menu">Enreg Fact F </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoix.jsp&premier=true" class="menu">Attacher Facture LC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureAviser.jsp&nature=<%=Constante.getObjFactureProf()%>&premier=true" class="menu">Viser Facture F</a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOpSansLc.jsp" class="menu">Etat Facture F </a>&nbsp;</td>
                            </tr>
                             <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFournisseurliste.jsp&premier=true" class="menu">Lister Facture F </a>&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFournisseurGroupe.jsp&premier=true" class="menu">Groupe Facture F </a>&nbsp;&nbsp;</td>
                            </tr>
                            <!--<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeFactureFournisseur.jsp&nature=<%=Constante.getObjFactureProf()%>&premier=true" class="menu">Lister Fact Prof F </a>&nbsp;&nbsp;</td>
                            </tr>-->
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/formFactureFournisseurPrevision.jsp" class="menu">Prevision Facture Fournisseur </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/listeFactureFournisseurPrevision.jsp" class="menu">Lister Prevision Facture Fournisseur </a></td>
                            </tr>
                        </table>
                </td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
            </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td width="92%" height="10">&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
		<tr><td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Taches</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pointage/Tache.jsp" class="menu">nouvelle Tache </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/listeTache.jsp" class="menu">Lister Tache </a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/saveContact.jsp" class="menu">Nouveau contact </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/listContact.jsp" class="menu">Lister contact </a></td>
                            </tr>
                        </table></td>
                        <td bgcolor="#FFFFFF"></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
                </tr>
            <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td width="92%" height="10">&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Publicite</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listeCommissionPub.jsp" class="menu">Lister commission pub</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td width="92%" height="10">&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Comptes</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pcg/entreeCompte.jsp&acte=NEW" class="menu">Enregistrer</a>
                      </td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pcg/listeCompte.jsp" class="menu">Lister</a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td>&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
                <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Auto.
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
              <tr bgcolor="#364FA3">
                <td colspan="3">&nbsp;</td>
              </tr>
            </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Ded</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="#">Historique traffic</a> </td>
                    </tr>-->
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ded.jsp" class="menu">Cr&eacute;ation Ded </a></td>
                            </tr>
                            <!--<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Cr&eacute;ation Facture Pr </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureProfChoix.jsp" class="menu">Lettrage Ded Fac pr </a></td>
                            </tr>-->
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Lettrage Ded LC</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeDed.jsp&nature=<%=Constante.getObjetDed()%>" class="menu">Lister Ded </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeFactureProFormat.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Lister Facture Pr</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=<%=Constante.getObjetBc()%>" class="menu">Editer BC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerPayement.jsp" class="menu">Editer OP / facture F </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerPayementNormale.jsp" class="menu">Editer OP</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeBc.jsp&nature=<%=Constante.getObjetBc()%>" class="menu">Lister BC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOP.jsp&premier=true" class="menu">Lister OP </a></td>
                            </tr>
                            <tr>
                             <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPgroupe.jsp&premier=true" class="menu">Groupe OP </a></td>
                            </tr>
							<tr>
                             <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/entreeBenefPiece.jsp" class="menu">Enreg coursier</a></td>
                            </tr>
							<tr>
                             <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeBenefPiece.jsp" class="menu">Lister coursier</a></td>
                            </tr>
							<tr>
                             <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/entreeRetourPiece.jsp" class="menu">Enreg retour pi&egrave;ce</a></td>
                            </tr>
							<tr>
                             <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/etatPiece.jsp" class="menu">Etat pi&egrave;ce</a></td>
                            </tr>
                        </table></td>
                        <td bgcolor="#FFFFFF"></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">D&eacute;penses</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/mvtCaisseDepense.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/critereSortie.jsp" class="menu">Lister</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/reporter.jsp" class="menu">Reporter</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/virer.jsp" class="menu">Virer</a></td>
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
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="<%=lien%>?but=finance/critereCroiseSortie.jsp" class="menu">Analyse
                        crois&eacute;e </a></td>
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
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td>&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Utilisateur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
              <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp" class="menu">Entree facture</a></td>
                    </tr>

                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Pointage</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/pointage.jsp" class="menu">Enregistrer</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/criterePointage.jsp" class="menu">Lister
                        </a> </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="images/left_b.gif" width="15" height="10"></td>
                <td bgcolor="#ffffff"></td>
                <td> <img src="images/right_b.gif" width="15" height="10"></td>
              </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>

        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" heightA="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Aide</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="aide/ManuelUtilisateur.htm" class="menu">SPAT
                        TAC </a></td>
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
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
          session </a></div></td>
          <td width="4%">&nbsp;</td>
        </tr>
      </table></td>
    <td width="83%" align="center" valign="top" background="images/bg_m.gif">
      <table width="100%" height="100%" border="0">
        <tr>
          <td width="82%"><span class="modele">:: Administrateur du système</span> </td>
          <td width="18%">&nbsp;</td>
        </tr>
        <tr valign="top">
          <td height="29"> <div align="center">
            <jsp:include page='<%=but%>'/></div>

      </td>
          <td><table width="100%"  border="0">
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Ed&deg; / An. Facture</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td colspan="3" bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeHistoriqueFacture.jsp" class="menu">Lister
                        historique </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>-->
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/client.jsp" class="menu">Enregistrer client</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeClient.jsp" class="menu">Lister client </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facture/factureInit.jsp&acte=-" class="menu">Nouvelle Facture</a></td>
                            </tr>
                             <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoixRct.jsp" class="menu">Attacher Fact Client </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureRecetteAviser.jsp" class="menu">Viser Facture Client </a></td>
                            </tr>&nbsp;
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOrSansLc.jsp" class="menu">Etat Facture Client</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFactureAnalyse.jsp" class="menu">Analyser </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFacture.jsp" class="menu">Lister </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOr.jsp" class="menu">Lister Facture Client </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureClientGroupe.jsp&premier=true" class="menu">Groupe Facture Client </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/factureInitProf.jsp" class="menu">Nouv facture prof </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listerFactureClientProf.jsp" class="menu">Lister facture prof </a></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Ligne Cr&eacute;dit Dep </td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff" align="center">
                  <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/creerLC.jsp" class="menu">Nouvelle LC</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeLC2.jsp" class="menu">Lister LC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/groupeLCDep.jsp" class="menu">Groupe LC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLC.jsp" class="menu">Copier LC </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/direction.jsp" class="menu">Cr&eacute;er Direction</a> </td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeDirection.jsp" class="menu">Lister Direction</a> </td>
                            </tr>
                        </table>
                   </td>
                </tr>
                <tr>
                  <td><img src="images/left_b.gif" width="15" height="10"></td>
                  <td bgcolor="#ffffff"></td>
                  <td> <img src="images/right_b.gif" width="15" height="10"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Ligne Cr&eacute;dit Rec </td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff" align="center">
                  <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/creerLCRecette.jsp" class="menu">Nouvelle LC Rec </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeLC2Recette.jsp" class="menu">Lister LC rec </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/groupeLCRec.jsp" class="menu">Groupe LC rec </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLCRecette.jsp" class="menu">Copier LC Rec </a></td>
                            </tr>
                        </table>
                  </td>
                </tr>
                <tr>
                  <td><img src="images/left_b.gif" width="15" height="10"></td>
                  <td bgcolor="#ffffff"></td>
                  <td> <img src="images/right_b.gif" width="15" height="10"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Caisse</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff" align="center">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/caisse.jsp" class="menu">Enregistrer</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCaisse.jsp" class="menu">Lister caisse</a>
                      </tr>
                                                  <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp&premier=true" class="menu">Lister mouvement caisse sans LC </a>                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/groupeMvtCaisseSansLc.jsp&premier=true" class="menu">Groupe mouvement caisse sans LC</a>                            </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisse.jsp" class="menu">Lister mouvement caisse</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/mvtCaisse.jsp&typeObjet=ORDONNERPAYEMENT" class="menu">Mouvement caisse depense</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/mvtCaisse.jsp&typeObjet=ORDONNERRECETTE" class="menu">Mouvement caisse recette</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCheque.jsp" class="menu">Lister cheque </a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/etatCaisse.jsp" class="menu">Etats de caisse</a>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td><img src="images/left_b.gif" width="15" height="10"></td>
                  <td bgcolor="#ffffff"></td>
                  <td> <img src="images/right_b.gif" width="15" height="10"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
                  <td><table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Virement</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td colspan="3" bgcolor="#ffffff" align="center"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/virer.jsp" class="menu">Cr&eacute;er</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeVirement.jsp" class="menu">Lister Virement </a>
                           </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/rib.jsp" class="menu">Enreg RIB</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/rapprochement.jsp" class="menu">Rapprochement</a>
							</tr>
                           <!--<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listerRib.jsp" class="menu">A rapprocher</a>
                           </tr>-->
						   <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeribnonr.jsp" class="menu">Lister RIB</a>
							</tr>
							<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeChequeNonR.jsp" class="menu">Cheque paye non R</a>                            </tr>
							  <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisseNonRapproche.jsp&premier=true" class="menu">lister mvt caisse non rapproch&eacute;</a>
							</tr>
                            <tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
                </tr>
				<tr>
                  <td>&nbsp;</td>
                </tr>

                <!--<tr>
                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Prévisions</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td colspan="3" bgcolor="#ffffff" align="center"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/creerPrevisionDepense.jsp" class="menu">Saisir prevision D&eacute;p</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/creerPrevisionRecette.jsp" class="menu">Saisir prevision Rec</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionAViser.jsp" class="menu">Viser prevision Rec</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionDepAViser.jsp" class="menu">Viser prevision D&eacute;p</a></td>
                            </tr>
							<tr>
                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionDetail.jsp" class="menu">Liste Prévision</a></td>
                            </tr>
                            <tr>
                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevision.jsp" class="menu">Etat prévision</a></td>
                            </tr>
                            <tr>
                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionTranspose.jsp" class="menu">Etat prév Trans</a></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
                </tr>-->
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Recette / Or</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff" align="center">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/entree.jsp" class="menu">Enregistrer</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereEntree.jsp" class="menu">Lister</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/typeEntree.jsp" class="menu">Enr. type </a>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/listeTypeEntree.jsp" class="menu">Liste type de recette</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/billetage.jsp" class="menu">Billetage</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/convertirMonnaie.jsp" class="menu">Convertir</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/situationBalanceCompte.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>"" class="menu">Balances comptes </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerRecette.jsp" class="menu">Editer OR / facture C </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/ordonnerRecetteNormale.jsp" class="menu">Editer OR </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR.jsp" class="menu">liste OR </a></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td><img src="images/left_b.gif" width="15" height="10"></td>
                  <td bgcolor="#ffffff"></td>
                  <td> <img src="images/right_b.gif" width="15" height="10"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
      </table>
</td>
  </tr>
  <tr bgcolor="#364FA3">
    <td>&nbsp;</td>
    <td><div align="center"><span class="copy">&copy; JREWS
    Informatika</span> </div></td>
  </tr>
</table>
<script type="text/javascript">

function pagePopUp(page,width,height){
        w= 750;
        h= 600;
        t ="DETAILS";

        if (width!=null||width=="")
        {
                w=width;
        }
        if(height!=null||height==""){
                h = height;
        }

       window.open(page,t,"titulaireresizable=no,scrollbars=yes,location=no,width="+w+",height="+h+",top=0,left=0");
 }

 function getChoix(){
  setTimeout("document.frmselect.submit()",800);
}
</script>
</body>
</html>
