<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="facturefournisseur/apresModifFacture.jsp";
        String lien= null;
                facture.Client clt[] = null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
                TypeObjet ag[] =null;
        Caisse caiss[] = null;
        String numObjet = null;
        facture.Tva tva = null;
        String nature=null;
        FactureFournisseur bc = null;

%>
<%
    numObjet = request.getParameter("numObjet");
    nature = request.getParameter("nature");
    if ((nature == null) || nature.compareTo("") == 0) {
        nature = "factureF";
    }
    if (numObjet == null) {
        numObjet = "";
    }
    try {

        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        out.println("lien = " + lien);

        System.out.println("AVANT = " + nature + "    " + numObjet);
        bc = u.findFactureFournisseur(nature, numObjet, "", "", "%", "%", "IDFACTUREFOURNISSEUR", "asc", "")[0];
//findFactureFournisseur(nature, numObjet, "", "", "%","%","%","asc", "")[0];
        System.out.println("APRES = ");
        dev = u.findTypeObjet("Devise", "%", "%");
        clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
        tva = u.loadTva(Utilitaire.dateDuJour());
        /*tyo = u.findTypeObjet("TypeEntree","%","%");
         clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
         clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
         mp = u.findTypeObjet("ModePaiement","%","%");
         ag = u.findTypeObjet("Agence","%","%");
         dev = u.findTypeObjet("Devise","%","%");
         source = u.findTypeObjet("Beneficiaire","%","%");
         caiss = u.findCaisse("%","%","%","%");*/

    } catch (Exception e) {
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
<%
    }
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Modification <%=nature%></h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value) && verifie(designation.value) && verifie(montant.value))">

    <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                    <tr>
                        <td class="left">ID<%=nature%>: <span class="remarque">*</span></td>
                        <td align="center"> <input name="id" type="text" class="champ"  id="id" value="<%=bc.getTuppleID()%>">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Num <%=nature%>: <span class="remarque">*</span></td>
                        <td align="center"> <input name="numFact" type="text" class="champ"  id="numFact" value="<%=bc.getNumFact()%>" readonly="true">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="left">Designation: <span class="remarque">*</span></td>
                        <td align="center"> <input name="designation" type="text" class="champ"  id="designation"  value="<%=bc.getDesignation()%>">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Date : <span class="remarque">*</span></td>
                        <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%= Utilitaire.formatterDaty(bc.getDaty())%>">
                            &nbsp;           </td>
                        <td align="center"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>  </td>
                    </tr>
                    <tr>
                        <td class="left">Fournisseur: <span class="remarque">*</span></td>
                        <td align="center">          <input type="text" class="champ" name="fournisseur" value="<%=bc.getIdFournisseur()%>" readonly="true"/>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <!--            <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('ded/choix_tiers.jsp?champReturn=fournisseur')" value="..." /></td>-->
                    </tr>
                    <tr>
                        <td class="left">Montant (TTC) : </td>
                        <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" value="<%=bc.getMontantTTC()%>" readonly="true"/>
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">TVA : </td>
                        <td align="center"> <input name="tva" type="text" class="champ" id="tva" value="<%=bc.getIdTVA()%>">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Devise : <span class="remarque">*</span></td>
                        <td align="center"> <select name="idDevise" class="champ" id="idDevise">
                                <option value="Ar">Ar</option>
                                <%
                                    for (int i = 0; i < dev.length; i++) {
                                %>
                                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                                <%
                                    }
                                %>
                            </select> &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left">Remarque : </td>
                        <td align="center"> <input name="remarque" type="text" class="champ" id="remarque" maxlength="20"  value="<%=bc.getRemarque()%>">
                            &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left" valign="top">Date emission:</td>
                        <td align="center"> <input name="dateemission" type="text" class="champ" id="dateemission" value="<%=Utilitaire.formatterDaty(bc.getDateEmission())%>" maxlength="10">
                            &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left" valign="top">Date d'&eacute;cheance:</td>
                        <td align="center"> <input name="datyecheance" type="text" class="champ" id="datyecheance" value="<%= bc.getDatyecheance() != null ? Utilitaire.formatterDaty(bc.getDatyecheance()) : null%>" maxlength="10">
                            &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>            </td>
                        <td align="center">&nbsp;</td>
                    </tr>
                </table></td>
        </tr>
        <tr>
            <%
                FactureMereProforma factureMere = new FactureMereProforma();
                factureMere.setNomTable("FACTUREMERE");
                factureMere = (FactureMereProforma) CGenUtil.rechercher(factureMere, null, null, " and idfacturemere='" + bc.getNumFact() + "'")[0];
                FactureFille factureFille = new FactureFille();
                factureFille.setNomTable("FACTUREFILLE");
                FactureFille[] listeFactureFilles = (FactureFille[]) CGenUtil.rechercher(factureFille, null, null, " and IDFACTUREMERE='" + factureMere.getIdFactureMere() + "'");
            %>
              <input name="factmere" id="factmere" type="hidden" value="<%=factureMere.getIdFactureMere()%>" />
           
            <p align="center"><strong><u>Liste des factures fille pour la facture client:<%=bc.getTuppleID()%></u></strong></p>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
                  <!--DWLayoutTable-->
                  <tr class="head">
                    <td width="5%" valign="top"><!--DWLayoutEmptyCell-->ID</td>
                    <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
                    <td width="12%" height="19" valign="top"><div align="center"><strong>Facture Mï¿½re</strong></div></td>
                    <td width="12%" valign="top"><div align="center"><strong>Unitï¿½</strong></div></td>
                    <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td width="10%" valign="top"><div align="center"><strong>Prix Unitaire</strong></div></td>
                    <td width="10%" align="center" valign="top"><strong>Quantitï¿</strong></td>
                    <td width="13%" valign="top"><div align="center"><strong>Rï¿½duction</strong></div></td>
                    <td width="11%" valign="top"><div align="center"><strong>Ref OBj</strong></div></td>
                  </tr>
                   <input name="nombreFF" id="nombreFF" type="hidden" value="<%=listeFactureFilles.length%>" />
                <%
                    for(int i=0;i<listeFactureFilles.length;i++){
                %>
                    <tr>                    
                    <input name="idfacturefille_<%=i%>" id="idfacturefille_<%=i%>" type="hidden" value="<%=listeFactureFilles[i].getIdFactureFille()%>" />
                        <td align="left" valign="top">
                        <div align="right"><%=listeFactureFilles[i].getIdFactureFille()%></div></td>
                        <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        <td align="left" valign="top"><div align="left"><%=listeFactureFilles[i].getDesignation()%></div></td>
                        <td align="left" valign="top">
                        <div align="center"><%=listeFactureFilles[i].getIdFactureMere()%></div></td>
                        <td align="right" valign="top"><%=listeFactureFilles[i].getIdUnite()%></td>
                        <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        <td align="right" valign="top"><div align="right">
                            <input value="<%=listeFactureFilles[i].getPrixUnitaire()%>" class="champ" name="prixunitaire_<%=i%>" id="prixunitaire_<%=i%>" type="text" />
                        </div></td>
                      <td align="right" valign="top">
                          <div align="center">
                              <input value="<%=listeFactureFilles[i].getQuantite()%>" class="champ" name="quantite_<%=i%>" id="quantite_<%=i%>" type="text"/>
                          </div>
                      </td>
                      <td align="right" valign="top"><div align="center"><input value="<%=listeFactureFilles[i].getReduction()%>" class="champ" name="reduction_<%=i%>" id="reduction_<%=i%>"/></div></td>
                      <td align="right" valign="top"><div align="center"><%=listeFactureFilles[i].getRefObj()%></div></td>                      
                    </tr>
                <%
                    }
                %>
            </table>
        </tr>
        <tr>
            <td height="30" align="center">
                <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
                            <input name="acte" type="hidden" id="acte" value="UPDATE">
                            <input type="submit" name="Submit" value="Enregistrer" class="submit">
                        </td>
                        <td align="center">
                            <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>










</form>
<div align="center">
    <script language="javascript">
        var cal1 = new calendar1(document.forms['recette'].elements['daty']);
        cal1.year_scroll = false;
        cal1.time_comp = false;
        var cal1 = new calendar1(document.forms['recette'].elements['dateemission']);
        cal1.year_scroll = false;
        cal1.time_comp = false;
    </script>
    <span class="remarque">(*) Champs obligatoires</span></div>