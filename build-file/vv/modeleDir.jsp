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
<script src="jquery.js"></script>
<script src="jquery.alerts.js"></script>
<script src="jquery.plugins.js"></script>
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
          <td width="92%">&nbsp; </td>
          <td width="4%">&nbsp;</td>
        </tr>
                <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Actualités</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=actualite/saisiactu.jsp" class="menu">Saisir actualité</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=actualite/listeActu.jsp" class="menu">Lister actualité </a>&nbsp;&nbsp;</td>
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

        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td height="10"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Facture fournisseur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp" class="menu">Enreg Fact F </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOp.jsp" class="menu">Lister Facture F </a>&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFournisseurGroupe.jsp" class="menu">Groupe Facture F </a>&nbsp;&nbsp;</td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoix.jsp" class="menu">Attacher Facture LC </a></td>
                  </tr>
                  <!--<tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeFactureFournisseur.jsp&nature=<%=Constante.getObjFactureProf()%>" class="menu">Lister Fact Prof F </a>&nbsp;&nbsp;</td>
                  </tr>-->
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
          <td>&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
                <tr bgcolor="#364FA3">
                  <td>&nbsp;</td>
                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                      <td background="images/bg.gif" width="145" align="center" class="haut">Taches</td>
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
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>


        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Ded</td>
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
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPgroupe.jsp" class="menu">Groupe OP </a></td>
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
              <td background="images/bg.gif" width="145" align="center" class="haut">Gestion vente </td>
              <td width="15"><img src="images/right.gif" width="15" height="25"></td>
            </tr>
            <tr>
              <td bgcolor="#FFFFFF"></td>
              <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisivendeur.jsp" class="menu">Saisir vendeur</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisiprise.jsp" class="menu">Saisir prise </a>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listePrise.jsp" class="menu">Liste prise</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisinvendu.jsp" class="menu">Saisie invendu</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeInvendu.jsp" class="menu">Liste invendu </a>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisirecette.jsp" class="menu">Saisir recette</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=import.jsp" class="menu">Importer vente journal</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeRecette.jsp" class="menu">Liste recette </a></td>
                  </tr>
                  <tr>
                  <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/OrRecette.jsp" class="menu">OR via Liste recette </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/rechercheVente.jsp" class="menu">Etat de vente</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/etatVenteGroupe.jsp" class="menu">Etat de vente groupe</a></td>
                  </tr>
                  <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/calculCommissionGroupe.jsp" class="menu">Commission groupe </a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeVendeur.jsp" class="menu">Liste des vendeurs</a></td>
                  </tr>
                  <tr>
                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisiVendeurPrixJournal.jsp" class="menu">Prix indiv</a></td>
                  </tr>
                  <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listePrixJournalV.jsp" class="menu">Liste Prix indiv</a></td>
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
          <td width="4%">&nbsp;</td>
        </tr>
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td>&nbsp;</td>
          <td width="4%">&nbsp;</td>
        </tr>
        
        <tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td  width="15" height="25"><img src="images/left.gif" alt="" width="15" height="25"></td>
              <td background="images/bg.gif" width="94" align="center" class="haut">Admin gestion vente </td>
              <td width="23"><img src="images/right.gif" alt="" width="15" height="25"></td>
            </tr>
            <tr>
              <td bgcolor="#FFFFFF"></td>
              <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                <tr>
                  <td><img src="images/puce.gif" alt="" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=vendeur" class="menu">Modifier vendeur</a></td>
                </tr>
                <tr>
                  <td><img src="images/puce.gif" alt="" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=prise" class="menu">Modifier prise</a></td>
                </tr>
                <tr>
                  <td><img src="images/puce.gif" alt="" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=invendu" class="menu">Modifier invendu</a></td>
                </tr>
                <tr>
                  <td><img src="images/puce.gif" alt="" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=recette" class="menu">Modifier recette</a></td>
                </tr>
                <tr>
                  <td><img src="images/puce.gif" alt="" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=publication" class="menu">Modifier publication</a></td>
                </tr>
                <!--<tr>
                                                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/updateAdminGestionVente.jsp&type=parution" class="menu">Modifier parution</a></td>
						</tr>-->
              </table></td>
              <td bgcolor="#FFFFFF"></td>
            </tr>
            <tr>
              <td><img src="images/left_b.gif" alt="" width="15" height="10"></td>
              <td bgcolor="#ffffff"></td>
              <td><img src="images/right_b.gif" alt="" width="15" height="10"></td>
            </tr>
          </table></td>
          <td width="4%">&nbsp;</td>
        </tr>
		<tr bgcolor="#364FA3">
          <td width="4%">&nbsp;</td>
          
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                <td background="images/bg.gif" width="145" align="center" class="haut">Gestion crieur</td>
                <td width="15"><img src="images/right.gif" width="15" height="25"></td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="#ffffff" align="center"> <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                    <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=importDistribution.jsp" class="menu">Import PRISE </a></td>
                    </tr>
                    <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=importDistributionInv.jsp" class="menu">Import INVENDU </a></td>
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
          <td width="4%">&nbsp;</td>
          <td><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
          session </a></div></td>
          <td width="4%">&nbsp;</td>
        </tr>
      </table></td>
    <td width="82%" align="center" valign="top" background="images/bg_m.gif">
      <table width="100%" height="100%" border="0">
        <tr>
          <td width="82%"><span class="modele">:: Directeur </span></td>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facture/factureInit.jsp&acte=-" class="menu">Nouvelle</a></td>
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
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOr.jsp" class="menu">Lister Facture C </a></td>
                      </tr>
                      <tr>
                                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOrSansLc.jsp" class="menu">Etat Facture C </a></td>
                      </tr>
<tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoixRct.jsp" class="menu">Attacher Fact Client </a></td>
                      </tr>
                      <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureClientGroupe.jsp" class="menu">Groupe Facture C </a></td>
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
                           <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listerRib.jsp" class="menu">A rapprocher</a>
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
                  <td background="images/bg.gif" width="110" align="center" class="haut">Recettes</td>
                  <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                </tr>
                <tr>
                  <td colspan="3" bgcolor="#ffffff" align="center">
                    <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/billetage.jsp" class="menu">Billetage</a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerRecette.jsp" class="menu">Editer OR / facture C </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/ordonnerRecetteNormale.jsp" class="menu">Editer OR </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR_o.jsp" class="menu">Liste OR </a></td>
                      </tr>
                      <tr>
                        <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR.jsp" class="menu">Groupe OR </a></td>
                      </tr>>
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
