<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>
<%!
        String but="index.jsp";
    String lien="modele.jsp";
    String lienContenu="index.jsp";
    UserEJB u = null;
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
<style type="text/css">
<!--
.Style1 {color: #364FA3}
-->
</style>
</head>
<body>
<link href="style/style.css" rel="stylesheet" type="text/css">
<div align="center">
  <table width="1024" border="0">
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td bgcolor="#364FA3"><img src="images/bateau.jpg" width="251" height="99"></td>
            <td bgcolor="#364FA3"><span class="titre"><img src="images/banner.gif" width="320" height="75"></span></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td width="14%" valign="top" bgcolor="#364FA3"><table width="100%" border="0">
                                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="94" align="center" class="haut">Actualit&eacute;s</td>
                        <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=actualite/saisiactu.jsp" class="menu">Saisir une actualit&eacute; </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=actualite/listeActu.jsp" class="menu">Lister actualit&eacute; </a>&nbsp;</td>
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
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
				<tr>
					<td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
					<td background="images/bg.gif" width="94" align="center" class="haut">Commercial</td>
					<td width="23"><img src="images/right.gif" width="15" height="25"></td>
				  </tr>
				  <tr>
					<td bgcolor="#FFFFFF"></td>
					<td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/saisie-societe.jsp" class="menu">Enreg societe</a></td>
						</tr>
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/historique-societe.jsp" class="menu">Histo societe</a></td>
						</tr>
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/saisie-pers-ste.jsp" class="menu">Personne resp societe</a></td>
						</tr>
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/liste-pers-ste.jsp" class="menu">Liste resp societe</a></td>
						</tr>
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/comm-resp-ste.jsp" class="menu">Comm. resp. societe</a></td>
						</tr>
						<tr>
						  <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=commercial/avancement-ste.jsp" class="menu">Avancement Etat societe</a></td>
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
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                      <td background="images/bg.gif" width="94" align="center" class="haut">Suivi Pub</td>
                      <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"></td>
                      <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pub/saveVerifPub.jsp" class="menu">Enreg suivi </a></td>
                          </tr>
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/statPubSaisie.jsp" class="menu">Listersuivi pub </a>&nbsp;</td>
                          </tr>
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubMep.jsp" class="menu">comparer </a>&nbsp;</td>
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
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="94" align="center" class="haut">Publicite</td>
                        <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pub/Pub.jsp" class="menu">Enreg pub </a></td>
                            </tr>
                            <tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePub.jsp" class="menu">Lister pub </a>&nbsp;</td>
                            </tr>
                            <tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubMep.jsp" class="menu">Mise en page </a>&nbsp;</td>
                            </tr>
                            <tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubCorr.jsp" class="menu">Corriger Pub </a></td>
                            </tr>
                            <tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubRemise.jsp" class="menu">Remiser </a></td>
                            </tr>
                             <tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/cloturePub.jsp" class="menu">Cloturer Pub </a></td>
                            </tr>
							<tr>
								<td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePub_ag.jsp" class="menu">OR via liste pub</a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/statPub.jsp" class="menu">Stat Pub </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listeTarif.jsp" class="menu">Liste Tarif </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/saveTarif.jsp" class="menu">Nouveau Tarif </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubGroupe.jsp" class="menu">Groupe Pub </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listeCommissionPub.jsp" class="menu">Commission pub </a></td>
                            </tr>
							<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePub_cnf.jsp" class="menu">Pub clotur&eacute; non factur&eacute</a></td>
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
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="94" align="center" class="haut">Parut&deg; / Public&deg; </td>
                        <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pub/Parution.jsp" class="menu">Enreg parution </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/savePublication.jsp" class="menu">Enreg publication </a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listeParution.jsp" class="menu">Lister parution </a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePublication.jsp" class="menu">Lister publication </a></td>
                            </tr>
                            <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/saveRubrique.jsp" class="menu">Ajout rubrique </a></td>
                            </tr>
                            <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listeRubrique.jsp" class="menu">Lister rubrique </a></td>
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
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">

                    <tr>
                      <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                      <td background="images/bg.gif" width="94" align="center" class="haut">Gestion vente </td>
                      <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"></td>
                      <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                      <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/insertjournal.jsp" class="menu">Créer Journal</a></td>
                    </tr>
                      <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeJournal.jsp" class="menu">Liste Journal</a></td>
                    </tr>
                          <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisivendeur.jsp" class="menu">Saisir vendeur</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisiprise.jsp" class="menu">Saisir prise
                        </a>
                    </tr>
<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listePrise.jsp" class="menu">Liste prise</a></td>
                      </tr>
                                                <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisinvendu.jsp" class="menu">Saisie invendu</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/clotureInvendu.jsp" class="menu">Cloturer invendu</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeInvendu.jsp" class="menu">Liste invendu
                        </a>
                    </tr>
                                                <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/saisirecette.jsp" class="menu">Saisir recette</a></td>
                    </tr>
                    <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/listeRecette.jsp" class="menu">Liste recette
                        </a></td> </tr>
                    <tr>
                     <tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/OrRecette.jsp" class="menu">OR via Liste recette </a></td>
                      </tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/rechercheVente.jsp" class="menu">Etat de vente</a></td>
                      </tr>
<tr>
                      <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ventegazety/etatVenteGroupe.jsp&premier=true" class="menu">Etat de vente groupe</a></td>
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
                </tr>
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
                    session </a></div></td>
                </tr>
            </table></td>
            <td width="71%" valign="top"><table width="100%" border="0">
                <tr>
                  <td><span class="modele">:: Administrateur du syst&egrave;me</span> </td>
                </tr>
                <tr>
                  <td><div align="center">
                  <a href='javascript:Popup("<%=lienContenu%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>
                    <jsp:include page='<%=but%>'/>
                  </div></td>
                </tr>
            </table></td>
            <td width="15%" valign="top"><table width="100%"  border="0">
                <tr>
                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Ed&deg; / An. Facture</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td colspan="3" bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
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
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOrSansLc.jsp" class="menu">Etat Facture Client</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/critereEntreFactureOr.jsp" class="menu">Lister Facture C </a></td>
                            </tr>
<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureClientGroupe.jsp&premier=true" class="menu">Groupe Facture C </a></td>
                            </tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureFChoixRct.jsp" class="menu">Attacher Fact Client </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/listeFactureRecetteAviser.jsp" class="menu">Viser Facture C </a></td>
                            </tr>&nbsp;
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
                        <td background="images/bg.gif" width="110" align="center" class="haut">Admin client </td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td colspan="3" bgcolor="#ffffff" align="center"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/miseAJourClient.jsp" class="menu">Mise &agrave; jour client </a></td>
                            </tr>
                            <!--<tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/deleteClient.jsp" class="menu">Supprimer client </a></td>
                            </tr>-->
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
                        <td colspan="3" bgcolor="#ffffff" align="center"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
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
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/situationEntreeCompte.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Analyse cat rec</a></td>
                              </tr>
                              <tr>
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/situationBalanceCompte.jsp&dateDebut=<%=Utilitaire.dateDuJour()%>&dateFin=<%=Utilitaire.dateDuJour()%>" class="menu">Balances comptes </a></td>
                              </tr>
                              <tr>
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerRecette.jsp" class="menu">Editer OR / facture C </a></td>
                              </tr>
                              <tr>
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/ordonnerRecetteNormale.jsp" class="menu">Editer OR </a></td>
                              </tr>
                              <tr>
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR_o.jsp&premier=true" class="menu">Liste OR </a></td>
                              </tr>
                              <tr>
                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR.jsp&premier=true" class="menu">Groupe OR </a></td>
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

                <!--debut compteG-->
                <!--fin compteG-->
            </table></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td><div align="center"><span class="copy">&copy; JREWS
        Informatika</span> </div></td>
    </tr>
  </table>
</div>
</body>

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

</html>
