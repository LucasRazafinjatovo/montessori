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
    <td width="18%" valign="top"  bgcolor="#C300FF"> <table width="100%" border="0" cellspacing="0" bgcolor="#8CB0F8">
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
                <td background="images/bg.gif" width="94" align="center" class="haut">Facture fournisseur</td>
                <td width="23"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp" class="menu">Enreg Fact F </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOpSansLc.jsp" class="menu">Etat Facture F </a>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOp.jsp" class="menu">Lister Facture F </a>&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoix.jsp" class="menu">Attacher Facture LC </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeFactureFournisseur.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Lister Fact Prof F </a>&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureAviser.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Viser Facture F</a>&nbsp;</td>
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
          <td>&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
              <td background="images/bg.gif" width="110" align="center" class="haut">Gestion papier </td>
              <td width="15"><img src="images/right.gif" width="15" height="25"></td>
            </tr>
            <tr>
              <td colspan="3" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=stock/saisie_parution.jsp" class="menu">nouvelle Parution </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=stock/saisie_standard.jsp" class="menu">saisie standard </a>&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=stock/mouvement_entre_depot.jsp" class="menu">mvt d&eacute;pot </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=stock/emprunt.jsp" class="menu">emprunt</a></td>
                  </tr>
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
          <td>&nbsp;</td>
          <td height="10">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
              <td background="images/bg.gif" width="110" align="center" class="haut">Taches</td>
              <td width="15"><img src="images/right.gif" width="15" height="25"></td>
            </tr>
            <tr>
              <td colspan="3" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pointage/Tache.jsp" class="menu">nouvelle Tache </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/listeTache.jsp" class="menu">Lister Tache </a>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=stock/mouvement_entre_depot.jsp" class="menu">Nouveau contact </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=stock/emprunt.jsp" class="menu">Lister contact </a></td>
                  </tr>
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
          <td>&nbsp;</td>
          <td height="10">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>




        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
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
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td>&nbsp;</td>
          <td height="10">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Comptes</td>
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
              <tr bgcolor="#364FA3">
                <td colspan="3">&nbsp;</td>
              </tr>
            </table></td>
          <td width="4%">&nbsp;</td>
        </tr>


        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="110" align="center" class="haut">Ded</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="#">Historique traffic</a> </td>
                    </tr>-->
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ded.jsp" class="menu">Cr&eacute;ation Ded </a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Cr&eacute;ation Facture Pr </a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureProfChoix.jsp" class="menu">Lettrage Ded Fac pr </a></td>
                    </tr>
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
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOP.jsp" class="menu">Lister OP </a></td>
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
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td>&nbsp;</td>
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
                <td background="images/bg.gif" width="110" align="center" class="haut">Analyses</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
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
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/tableauBord.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Tableau de bord</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/tableauBordCaisse.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Etat Caisse jour </a></td>
                    </tr>
                                                            <tr>
                                                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=lc/listeFCC.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">FCC D&eacute;penses</a></td>
                    </tr>

                                                            <tr>
                                                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=lc/listeFCCRecette.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">FCC Recettes </a></td>
                                                            </tr>
                                                                                                                                          <tr>
                                                                                                                                            <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="lc/listeFCCSynthese.jsp?dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">FCC Synth&egrave;se </a></td>
                                                                                                                                          </tr>
                                                                                                                                          <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/situationSortieCompte.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Analyse cat dep </a></td>
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
                <td background="images/bg.gif" width="110" align="center" class="haut"> Info Entités</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=createInfoSpat.jsp" class="menu">Créer
                        Info.</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=listeInfoSociete.jsp" class="menu">Lister
                        Info.</a></td>
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
                <td background="images/bg.gif" width="110" align="center" class="haut">Pointage</td>
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
          <td width="4%">&nbsp;</td>
          <td><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
          session </a></div></td>
          <td width="4%">&nbsp;</td>
        </tr>
      </table></td>
    <td width="82%" align="center" valign="top" background="images/bg_m.gif">
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
                  <td colspan="3" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facture/factureInit.jsp" class="menu">Nouvelle</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFactureAnalyse.jsp" class="menu">Analyser </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/critereFacture.jsp" class="menu">Lister </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                      </tr>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOrSansLc.jsp" class="menu">Etat Facture Client</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOr.jsp" class="menu">Lister Facture C </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoixRct.jsp" class="menu">Attacher Fact Client </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureRecetteAviser.jsp" class="menu">Viser Facture C </a></td>
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
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLCRecette.jsp" class="menu">Copier LC Rec </a></td>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLC.jsp" class="menu">Copier LC </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/direction.jsp" class="menu">Cr&eacute;er Direction</a> </td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeDirection.jsp" class="menu">Lister Direction</a> </td>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp" class="menu">Lister mouvement caisse sans LC </a>                       
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisse.jsp" class="menu">Lister mouvement caisse</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCheque.jsp" class="menu">Lister cheque </a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/etatCaisse.jsp" class="menu">Etats de caisse</a>
                      </tr>
					   <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/etatDeCaisse.jsp" class="menu">Etats de rapprochement</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/reporter.jsp" class="menu">Reporter</a>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/virer.jsp" class="menu">Virer</a>
                      </tr>
                      <tr>
                        <td>
                      </tr>
                      <tr>
                        <td>
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
                  <td colspan="3" bgcolor="#ffffff" align="center">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/virer.jsp" class="menu">Cr&eacute;er</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeVirement.jsp" class="menu">Lister Virement </a>
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
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Visa</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <!--<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;
                        <a href="#">Historique traffic</a> </td>
                    </tr>-->
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaDED.jsp" class="menu">Visa Ded </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaOrdrePayement.jsp" class="menu">Visa OP </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Liste Visa Ded </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Liste Visa OP </a></td>
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
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Recettes</td>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/tableauBordTrosa.jsp" class="menu">Tableau des emprunts</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereCroiseEntree.jsp" class="menu">Analyser crois&eacute;e</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereEtatFacture.jsp" class="menu">Analyser par facture</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/billetage.jsp" class="menu">Billetage</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/convertirMonnaie.jsp" class="menu">Convertir</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/situationEntreeCompte.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>"" class="menu">Analyse cat rec</a></td>
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
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" heightA="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Aide</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">SPAT TAC </a></td>
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
            </tr>
			<tr>
              <td>&nbsp;</td>
            </tr>
			 <tr>
              <td height="118"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td  width="15" heightA="25"><img src="images/left.gif" width="15" height="25"></td>
                  <td background="images/bg.gif" width="110" align="center" class="haut">Publicit&eacute;</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
					  <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Remise </a></td></tr>
						<tr>
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Publicité </a></td></tr>
						<tr>
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Publicité multiple </a></td></tr>
						<tr>
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Nombre par agence </a></td></tr>
						<tr>
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Suivi </a></td></tr><tr>
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Nombre par agence </a></td></tr>
						
						<td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">Recherche </a></td>
						
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
