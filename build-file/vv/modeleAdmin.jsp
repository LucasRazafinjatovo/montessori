<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>
<%!
    String but = "index.jsp";
    String lien = "modele.jsp";
    String lienContenu = "index.jsp";
    UserEJB u = null;
%>
<%
    if (session.getValue("lien") != null) {
        lien = (String) session.getValue("lien");
    }
    if ((request.getParameter("but") != null) && session.getValue("u") != null) {
        but = request.getParameter("but");
        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getValue("u");
    } else {
        but = "index.jsp";
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Gestion de scolarit&eacute;</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="style/style.css" rel="stylesheet" type="text/css">
        <script src="calendar/calendar1.js"></script>
        <script src="jquery.js"></script>
        <script src="controleTj.js"></script>
        <script src="jquery.alerts.js"></script>
        <script src="jquery.plugins.js"></script>
        <SCRIPT language="JavaScript" src="script.js"></script>
        <style type="text/css">
        </style>
    </head>
    <body>
    <link href="style/style.css" rel="stylesheet" type="text/css">
   
    <div align="center">
        <table width="1024" border="0">
            <tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td bgcolor="#364FA3"><img src="images/logopng.png" width="251" height="99"></td>
                            <td bgcolor="#364FA3"><span class="titre"><img src="images/banner.jpg" width="320" height="75"></span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td width="14%" valign="top" bgcolor="#364FA3">
                                <table width="100%" border="0">                                    
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="94" align="center" class="haut">Etudiant</td>
                                                    <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=etudiant/formEtudiant.jsp" class="menu">Saisir un etudiant </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/listeEtudiant.jsp" class="menu">Listes etudiants</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/InscriptionAnneescolaireEtudiant.jsp" class="menu">Inscription etudiant</a>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/abondant-etudiant.jsp" class="menu">Abondant etudiant</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/listeEtudiantAbandonnes.jsp" class="menu">Listes etudiants abandonn&eacute;s</a>&nbsp;</td>
                                                            </tr>
                                                           
                                                        
                            
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                   <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="94" align="center" class="haut">Configuration</td>
                                                    <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=rubrique/rubrique-prix-entite-saisie.jsp" class="menu">Saisie configuration</a>&nbsp;</td>
                                                            </tr>
                                                                <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=rubrique/rubrique-prix-entite-liste.jsp" class="menu">Liste configurations</a>&nbsp;</td>
                                                            </tr>
                                                                 <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/saisie-niveau.jsp" class="menu">Saisir niveau</a>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/liste-niveau.jsp" class="menu">Liste niveau</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/anneeScolaire.jsp" class="menu">Saisie un nouveau anne&eacute; scolaire</a>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/listeAnneeScolaire.jsp" class="menu">Liste ann&eacute;e scolaire</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/anneeEnCours.jsp" class="menu">Modif anne&eacute; en cours</a>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="94" align="center" class="haut">Paiement</td>
                                                    <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                               <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/generer-facture.jsp" class="menu">Generer facture </a>&nbsp;</td>
                                                            </tr>
                                                               <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/liste-facture.jsp" class="menu">Listes facture</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/liste-etudiant-non-facturer.jsp" class="menu">Listes etudiants non factur&eacute;s</a>&nbsp;</td>
                                                            </tr>
                                                           
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/etat-analyse-paiement.jsp" class="menu">Etat d'analyse paiement</a>&nbsp;</td>
                                                            </tr>
                                                           
                                                              <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/saisie-depense.jsp" class="menu">Saisir d&eacute;pense</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/liste-depense.jsp" class="menu">Liste d&eacute;pense</a>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/saisie-report.jsp" class="menu">saisie report</a>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/liste-report.jsp" class="menu">liste report</a>&nbsp;</td>
                                                            </tr>
                                                             <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=etudiant/etat-caisse.jsp" class="menu">Etat de caisse</a>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    
                                 
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="94" align="center" class="haut">Fact frnss</td>
                                                    <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff">
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
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/formFactureFournisseurPrevision.jsp" class="menu">Prevision Facture Fournisseur </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/listeFactureFournisseurPrevision.jsp" class="menu">Lister Prevision Facture Fournisseur </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facturefournisseur/liste-facture-tvaht.jsp" class="menu">Lister Facture F. Detaillés </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=facture/etatFacturePayee.jsp" class="menu">Declaration TVA</a></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    
                                   
                                  
                                   
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut">Ded</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
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
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOP-Compte.jsp&premier=true" class="menu">Liste OP Compte</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/OP-multiple.jsp&premier=true" class="menu">MAJ OP date de paiement</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPgroupe_tdp.jsp&premier=true" class="menu">MAJ OP date de paiement Groupe</a></td>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPgroupe.jsp&premier=true" class="menu">Groupe OP </a></td>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPgroupeCompte.jsp&premier=true" class="menu">Groupe OP Compte</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/avantAnnulationOP.jsp" class="menu">Annuler OP</a></td>
                                                            </tr>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/ordonnerpayementreste-annuler.jsp" class="menu">Annuler OP multiple</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/op_a_decaler.jsp" class="menu">Reporter OP </a></td>
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
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut">Analyses</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/beneficiaire.jsp" class="menu">Enregistrer
                                                                        b&eacute;n.</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/listeBeneficiaire.jsp" class="menu">Lister
                                                                        b&eacute;n&eacute;ficiaire </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/critereCroiseSortie.jsp" class="menu">Analyse
                                                                        crois&eacute;e </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/typeSortie.jsp" class="menu">Enr.
                                                                        type de d&eacute;p.</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/listeTypeSortie.jsp" class="menu">Liste
                                                                        type de d&eacute;p.</a>
                                                                </td>
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
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut"> Info Entit&eacute;s</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=createInfoSpat.jsp" class="menu">Cr&eacute;er
                                                                        Info.</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=listeInfoSociete.jsp" class="menu">Lister
                                                                        Info.</a>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <!--DWLayoutTable-->
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut">Historique</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=historique/critereHistorique.jsp" class="menu">Lister</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    <%if (u.getUser().getLoginuser().compareToIgnoreCase("Max") != 0) {%>
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut">Utilisateur</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/utilisateur.jsp" class="menu">Enregistrer</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/listeUtilisateur.jsp" class="menu">Lister </a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/entreeFacture.jsp" class="menu">Entree facture</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/formRestriction.jsp" class="menu">Saisir Restriction</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/listeRestriction.jsp" class="menu">Lister restriction</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/formListeTable.jsp" class="menu">Saisir Table</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=utilisateur/listeTable.jsp" class="menu">Lister Table</a></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%}%>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="110" align="center" class="haut">Pointage</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#FFFFFF"></td>
                                                    <td bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/pointage.jsp" class="menu">Enregistrer</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/criterePointage.jsp" class="menu">Lister </a>                            
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td bgcolor="#FFFFFF"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Style1">&nbsp;</td>
                                    </tr>
                                    
                                    <tr>
                                        <td class="Style1">
                                            <div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
                                                    session </a>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="71%" valign="top">
                                <table width="100%" border="0">
                                    <tr>
                                        <td><span class="modele">:: Administrateur du syst&egrave;me</span> </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div align="center">
                                                <a href='javascript:Popup("<%=lienContenu%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aper&ccedil;u</a>
                                                <jsp:include page='<%=but%>'/>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14%" valign="top" bgcolor="#364FA3">
                                <table width="100%"  border="0">
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Ed&deg; / An. Facture</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <!--<tr>
                                                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/listeHistoriqueFacture.jsp" class="menu">Lister
                                                                 historique </a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                               </tr>-->
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=comptabilite/comptetiersmultiple-saisie.jsp" class="menu">Enregistrer client</a></td>
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
                                                            </tr>
                                                            &nbsp;
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
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facturefournisseur/liste-factureclient-tvaht.jsp" class="menu">Lister Facture C. Detaillés </a></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Compte rendu </td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=compte/compteRendu.jsp" class="menu">Compte rendu journalier</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=compte/rapport.jsp" class="menu">Rapport DAF journalier</a></td>
                                                            </tr>
                                                            <!--<tr>
                                                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=facture/deleteClient.jsp" class="menu">Supprimer client </a></td>
                                                               </tr>-->
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Admin LC </td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/modifLCDepense.jsp" class="menu">D&eacute;pense</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/modifLCRecette.jsp" class="menu">Recette</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/groupeLCDepF.jsp" class="menu">Groupe LC</a></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Ligne Cr&eacute;dit Rec </td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/creerLCRecette.jsp" class="menu">Nouvelle LC Rec </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/saisietypelcrecette.jsp" class="menu">Nouv. Type ligne </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeTypeLcRec.jsp" class="menu">Lister Type LC </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeLC2Recette.jsp" class="menu">Lister LC rec </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/groupeLCRec.jsp" class="menu">Groupe LC rec </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/dupliquerListeLCRecette.jsp" class="menu">Dupliquer LC Rec </a></td>
                                                            </tr>
                                                            <!-- <tr>
                                                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLCRecette.jsp" class="menu">Copier LC Rec </a></td>
                                                               </tr> -->
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/left_b.gif" width="15" height="10"></td>
                                                    <td bgcolor="#ffffff"></td>
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" border="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Ligne Cr&eacute;dit Dep </td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/creerLC.jsp" class="menu">Nouvelle LC</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/saisietypelcdepense.jsp" class="menu">Nouv. Type ligne </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeLC2.jsp" class="menu">Lister LC </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/listeTypeLcDep.jsp" class="menu">Lister Type LC </a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/groupeLCDep.jsp" class="menu">Groupe LC </a></td>
                                                            </tr>
                                                            <!--<tr>
                                                               <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/copierLC.jsp" class="menu">Copier LC </a></td>
                                                               </tr>-->
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=lc/dupliquerListeLC.jsp" class="menu">Dupliquer LC </a></td>
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
                                                    <td><img src="images/right_b.gif" width="15" height="10"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" border="0">
                                                <tr>
                                                    <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                                    <td background="images/bg.gif" width="170" align="center" class="haut">Caisse</td>
                                                    <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" bgcolor="#ffffff" align="center">
                                                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/caisse.jsp" class="menu">Enregistrer</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/clotureCaisse.jsp" class="menu">Cloturer caisse</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCaisse.jsp" class="menu">Lister caisse</a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp&premier=true" class="menu">Lister mouvement caisse sans LC </a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaissetvaetht.jsp&premier=true" class="menu">Liste mvt caisse avec TVA </a>                            
                                                            </tr>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/groupeMvtCaisseSansLc.jsp&premier=true" class="menu">Groupe mouvement caisse sans LC</a>                            
                                                            </tr>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/groupeMvtCaisseSansLc_tdp.jsp&premier=true" class="menu">Groupe mouvement caisse type</a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/etatMvtCaisseParDate.jsp&premier=true" class="menu">Etat mvt caisse par date</a>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisse.jsp&premier=true" class="menu">Lister mouvement caisse </a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/groupeMvtCaisse.jsp&premier=true" class="menu">Groupe mouvement caisse</a>                            
                                                            </tr>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/groupeMvtCaisseCompte.jsp&premier=true" class="menu">Groupe mvt caisse Compte</a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeCheque.jsp" class="menu">Lister cheque OR </a>                            
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeChequeNonR.jsp" class="menu">Cheque paye non R</a> 
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/etatCaisse.jsp" class="menu">Etats de caisse</a>                            
                                                            </tr>
                                                            <tr>
                                                            <tr>
                                                                <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="http://laptopdga:8080/vv/finance/etatDeCaisse.jsp" class="menu">Etats de rapprochement</a>
                                                            </tr>
                                                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="finance/groupeEtatCaisseTableau3.jsp?daty1=19/05/2017&daty2=19/05/2017" class="menu">Etat de caisse groupee</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeEtatCaisseTableau2.jsp" class="menu">Liste Etat de caisse groupee</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/reporter.jsp" class="menu">Reporter</a>                            
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/virer.jsp" class="menu">Virer</a>                            
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=finance/listeChequeRapprocherJour.jsp" class="menu">Liste cheque rapprocher/jour</a>
                                                </tr>
                                                <tr>
                                                    <td>                            
                                                </tr>
                                                <tr>
                                                    <td>                            
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" border="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Virement</td>
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
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/rib.jsp" class="menu">Enreg RIB</a></td>
                                                </tr>
                                                <!--<tr>
                                                   <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/rapprochement.jsp" class="menu">Rapprochement</a>
                                                   </tr>
                                                   <tr>
                                                   <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listerRib.jsp" class="menu">A rapprocher</a>
                                                   </tr>-->
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeribnonr.jsp" class="menu">Lister RIB</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/listeMvtCaisseNonRapproche.jsp&premier=true" class="menu">lister mvt caisse non rapproch&eacute;</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/rib-multiple.jsp" class="menu">lister RIB non rapproch&eacute;</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=finance/rapprochementMatching.jsp" class="menu">Ecran Matching</a>
                                                </tr>
                                                <tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Pr&eacute;visions</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff" align="center">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeOPPrevision.jsp" class="menu">Liste OP prevision</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/listeORPrevision.jsp" class="menu">Liste OR prevision</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionEtat.jsp" class="menu">Tableau recap.</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/formPrevision.jsp" class="menu">Saisir prevision dep</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/formPrevisionRecette.jsp" class="menu">Saisir prevision rec</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionDepesne.jsp" class="menu">liste prevision dep</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionRecette.jsp" class="menu">liste prevision rec</a>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="ded/mouvementcaisse-analyse.jsp" class="menu">Etat de pr&eacute;vision</a>&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Analyses prev & effectifs</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff" align="center">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionDetail.jsp" class="menu">Liste Pr&eaucte;vision D&eacute;p</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionRecDetail.jsp" class="menu">Liste Pr&eacute;vision Rec</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="prevision/analysePrevision.jsp" class="menu">Analyse Pr&eacute;v. & Effectifs</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="prevision/groupeAnalysePrevision.jsp" class="menu">Grouper analyse Pr&eacute;v. & Effectifs</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/groupePrevisionDepense.jsp" class="menu">Groupe prevision dep</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/groupePrevisionRecette.jsp" class="menu">Groupe prevision rec</a></td>
                                                </tr>
                                                <!--<tr>
                                                   <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionRecNonPaye.jsp" class="menu">Pr&eacute;v rec non pay&eacute;</a></td>
                                                   </tr>
                                                   <tr>
                                                   <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=prevision/listePrevisionDepNonPaye.jsp" class="menu">Pr&eacute;v dep non pay&eacute;</a></td>
                                                   </tr>-->
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <!--<tr>
                            <td>&nbsp;</td>
                        </tr>-->
                        <!--<tr style="display:none">
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Visa</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaDED.jsp" class="menu">Visa Ded </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaOrdrePayement.jsp" class="menu">Visa OP </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaOPMultiple.jsp" class="menu">Visa OP Multiple</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/visaORMultiple.jsp" class="menu">Visa OR Multiple</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Liste Visa Ded </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=penalites/listeParamPenalite.jsp" class="menu">Liste Visa OP </a></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>-->
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Recettes</td>
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
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR-compte.jsp&premier=true" class="menu">Liste OR Compte</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeOR.jsp&premier=true" class="menu">Groupe OR </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=ded/listeORGroupeeCompte.jsp&premier=true" class="menu">Groupe OR Compte</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=ded/reportOR.jsp" class="menu">Reporter OR</a></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <!--<tr style="display:none">
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Activa print</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff" align="center">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisitypearticle.jsp" class="menu">Saisir type papier</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisiarticle.jsp" class="menu">Saisir papier</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisigestionprix.jsp" class="menu">Saisir prix papier</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listearticlelibelle.jsp" class="menu">Liste papier</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisidemandedevis.jsp" class="menu">saisir dmd devis</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listedemandedevislibelle.jsp" class="menu">liste dmd devis non valide</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listedemandedevislibellevalide.jsp" class="menu">liste dmd devis valide</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisicommande.jsp" class="menu">Saisir commande </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listecommandelibelle.jsp" class="menu">Liste Commande</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisiproduction.jsp" class="menu">Saisir production</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=activa/listeproductionlibelle.jsp" class="menu">Liste production</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisilivraison.jsp" class="menu">saisir livraison</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listelivraisonlibelle.jsp" class="menu">liste livraison</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listeEtat.jsp" class="menu">Etat livraison Prod</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listeetatbeneficerecto.jsp" class="menu">Etat benefice Prod</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisitirage.jsp" class="menu">Saisir encre</a>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisimarge.jsp" class="menu">Saisir marge</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/listeMarge.jsp" class="menu">Liste marge</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=activa/saisimaintenance.jsp" class="menu">Saisir maintenance</a>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>-->
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <!--debut compteG-->
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">CompteG</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff" align="center">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=compte/formeCompteG.jsp" class="menu">Saisir compteG </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=compte/listeCompteG.jsp" class="menu">Lister compteG </a>&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td bgcolor="#FFFFFF"></td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <!--fin compteG-->
                        <tr>
                            <td> </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" heighta="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut"></td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="aide/ManuelUtilisateur.htm" class="menu">SPAT TAC </a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="admin/modifPub.jsp" class="menu">Pub</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="admin/modifMvtCaisse.jsp" class="menu">Mvt Caisse</a></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td> </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                                        <td background="images/bg.gif" width="170" align="center" class="haut">Comptabilit&eacute;</td>
                                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#ffffff" align="center">
                                            <table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/exercice-ouverture.jsp" class="menu">Ouvrir exercice</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/exercice-cloture.jsp" class="menu">Cloture exercice</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/exercice-report.jsp" class="menu">Reporter exercice</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/comptetiersmultiple-saisie.jsp" class="menu">Saisir Tiers</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/ecriture-saisie.jsp" class="menu">Saisir Ecriture</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/ecriture-complet.jsp" class="menu">Liste Ecriture</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/journal-etat.jsp" class="menu">Journal</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/balance-etat.jsp" class="menu">Balance</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/balancetiers-etat.jsp" class="menu">Balance tiers</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/grandlivre-complet.jsp&premier=true" class="menu">Grand livre</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/echeancier-etat.jsp&premier=true" class="menu">Echeancier</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/declaration-adeclarer.jsp" class="menu">Declaration</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/transcription.jsp" class="menu">Transcription</a></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/puce.gif" width="11" height="11">&nbsp;<a href="<%=lien%>?but=comptabilite/etatfinancier.jsp" class="menu">Etat financier</a></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td bgcolor="#FFFFFF"></td>
                                    </tr>
                                    <tr>
                                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                                        <td bgcolor="#ffffff"></td>
                                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td>
        <div align="center"><span class="copy">&copy; JREWS
                Informatika</span> 
        </div>
    </td>
</tr>
</table>
</div>
</body>
<script type="text/javascript">
    function pagePopUp(page, width, height) {
        w = 750;
        h = 600;
        t = "DETAILS";

        if (width != null || width == "")
        {
            w = width;
        }
        if (height != null || height == "") {
            h = height;
        }

        window.open(page, t, "titulaireresizable=no,scrollbars=yes,location=no,width=" + w + ",height=" + h + ",top=0,left=0");
    }

    function getChoix() {
        setTimeout("document.frmselect.submit()", 800);
    }
</script>
</html>