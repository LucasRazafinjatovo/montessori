<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
EtatCaisseGroupee p;
String date2 = Utilitaire.dateDuJour();
String date1 = Utilitaire.dateDuJour();
%>
<%
p = new EtatCaisseGroupee();
//p.setNomTable("etatcaissegroupejava");
p.setNomTable("ETATCAISSEGROUPE");
String listeCrt[] = {"daty","caisse"};
String listeInt[] = {"daty"};

String colDefaut[]={"caisse"};
String somDefaut[]={"report","nrdebit","nrcredit","rdebit","rcredit","tdebit","tcredit","soldetheorique","soldepratique"};
String moyenneDefaut[]={"plafonnement"};
PageRechercheGroupe pr = new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,moyenneDefaut,11,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("groupeEtatCaisseTableau3.jsp");
affichage.Champ[] liste = new affichage.Champ[1];
Caisse to = new Caisse();
to.setNomTable("caisse");
liste[0] = new Liste("caisse",to,"descCaisse","descCaisse", true);
pr.getFormu().changerEnChamp(liste);
pr.setNpp(400);
pr.setOrdre(" order by caisse asc");
pr.creerObjetPageMoyenne();
EtatCaisseGroupee[] list = (EtatCaisseGroupee[])pr.getRs().getResultat();
EtatCaisseGroupee temp = new EtatCaisseGroupee();
date1 = (request.getParameter("daty1") == null || request.getParameter("daty1").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty1");
date2 = (request.getParameter("daty2") == null || request.getParameter("daty2").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty2");

EtatCaisseGroupee[] pf = temp.calculer(list, date1, date2);

pr.getRs().setResultat(pf);
%>
<script type="text/javascript">
    function calculere(j)
    {
        var c;
        var dnet = 0;
        for (c = 0; c < j; c++)
        {
            var report = document.getElementById("report" + c).value;
            var Rdebit = document.getElementById("rdebit" + c).value;
            var Rcredit = document.getElementById("rcredit" + c).value;
            
            var NRdebit = document.getElementById("nrdebit" + c).value;
            var NRcredit = document.getElementById("nrcredit" + c).value;
			
            var plafonnement = document.getElementById("plafonnement" + c).value;

            var dispP = (parseFloat(Rcredit) + parseFloat(report) + parseFloat(plafonnement)) - parseFloat(Rdebit);
            var dispT = (parseFloat(NRcredit) + parseFloat(dispP)) - parseFloat(NRdebit);
            
            var disponibleT = dispT.toFixed(2);
            var disponibleP = dispP.toFixed(2);
            dnet += disponibleP;
            
            document.getElementById("soldetheorique" + c).value = disponibleT;
            document.getElementById("soldepratique" + c).value = disponibleP;
            
            
            for (var i = 0; i < Math.floor((disponibleP.length - (1 + i)) / 3); i++) {
                disponibleP = disponibleP.substring(0, disponibleP.length - (4 * i + 3)) + ' ' + disponibleP.substring(disponibleP.length - (4 * i + 3));
            }
            for (var i = 0; i < Math.floor((disponibleT.length - (1 + i)) / 3); i++) {
                disponibleT = disponibleT.substring(0, disponibleT.length - (4 * i + 3)) + ' ' + disponibleT.substring(disponibleT.length - (4 * i + 3));
            }
            document.getElementById("soldetheoriqueF" + c).value = disponibleT;
            document.getElementById("soldepratiqueF" + c).value = disponibleP;

           
            report = 0;
            Rdebit = 0;
            Rcredit = 0;
            NRdebit = 0;
            NRcredit = 0;
            plafonnement = 0;
            
        }
        var dneet = dnet.toFixed(2);
        for (var i = 0; i < Math.floor((dneet.length - (1 + i)) / 3); i++) {
            dneet = dneet.substring(0, dneet.length - (4 * i + 3)) + ' ' + dneet.substring(dneet.length - (4 * i + 3));
        }
        document.getElementById("dnet").value = dneet;
    }
</script>
<h1>Grouper etat de caisse</h1>
<form action="groupeEtatCaisseTableau3.jsp" method="post" name="groupePrev" id="groupePrev">
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tbody>
            <tr>
                <td align="left" class="left">daty1</td>
                <td align="center" class="champ"><input name="daty1" type="textbox" class="champ" id="daty1" ></td>
                <td></td>
                <td align="left" class="left">daty2</td>
                <td align="center" class="champ"><input name="daty2" type="textbox" class="champ" id="daty2" value=""></td>
                <td></td>
            </tr>
            <tr><td align="left" class="left">caisse</td><td align="center" class="champ"><select name="caisse" class="champ" id="caisse" multiple=""><option value="%">Tous</option><option value="airtel money">airtel money</option><option value="BFV ITU">BFV ITU</option><option value="BGFI VV">BGFI VV</option><option value="BMOI VV">BMOI VV</option><option value="BNI activa">BNI activa</option><option value="BNI BICI">BNI BICI</option><option value="BNI ITU ">BNI ITU </option><option value="BNI Tanj VV">BNI Tanj VV</option><option value="BOA Activa">BOA Activa</option><option value="Boa VV">Boa VV</option><option value="C Foire">C Foire</option><option value="C Hary VV">C Hary VV</option><option value="Caisse ITU">Caisse ITU</option><option value="caisse mvola">caisse mvola</option><option value="Euro">Euro</option><option value="Mvola   commerciale  ">Mvola   commerciale  </option><option value="Mvola ITU">Mvola ITU</option><option value="orange commercial">orange commercial</option><option value="orange dist">orange dist</option><option value="orange ITU">orange ITU</option><option value="Rand">Rand</option><option value="Sud Afrique">Sud Afrique</option></select></td><td></td><td align="left" class="left">debit1</td><td align="center" class="champ"><input name="debit1" type="textbox" class="champ" id="debit1" value=""></td><td></td></tr>
            </tbody>
    </table>

    <br><strong><font color="#FF0000" size="1">TRIER PAR </font></strong>
    <table width="100%">
        <tbody>
            <tr></tr>
            <tr><td> Colonne </td><td><select name="colonne" class="champ" id="colonne">
                        <option value="daty" selected="">daty</option>
                        <option value="caisse">caisse</option>
                        <option value="plafonnement">plafonnement</option>
                        <option value="report">report</option>
                        <option value="soldetheorique">soldetheorique</option>
                        <option value="soldepratique">soldepratique</option>
                    </select></td>
                    <td> Ordre </td><td><select name="ordre" class="champ" id="ordre">
                            <option value="DESC" selected="">DESC</option>
                            <option value="ASC">ASC</option></select></td></tr>
        </tbody>
    </table>

    <br><table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit"></td><td align="center"> <input type="reset" name="Submit" value="annuler" class="submit"></td></tr></tbody></table>
    <br/>
</form>

<br>
<div id="selectnonee">
    <form action="groupeEtatCaisseTableau3.jsp" method="POST" name="frmListe" id="frmListe">
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
            <tbody>
                <tr class="head">
                    <td width="20%" align="center" valign="top"></td>
                    <td width="20%" align="center" valign="top"></td>
                    <td width="20%" align="center" valign="top"></td>
                    <td colspan="2" align="center" valign="top">Cheque non rapproch&eacute;</td>
                    <td colspan="2" align="center" valign="top">Rapproch&eacute;</td>
                    <td colspan="2" align="center" valign="top">Solde</td>
                </tr>
                <tr class="head">
                    <td width="20%" align="center" valign="top">Caisse</td>
                    <td width="20%" align="center" valign="top">Report</td>
                    <td width="20%" align="center" valign="top">Plafonnement</td>
                    <td width="20%" align="center" valign="top">Debit</td>
                    <td width="20%" align="center" valign="top">Credit</td>
                    <td width="20%" align="center" valign="top">Debit</td>
                    <td width="20%" align="center" valign="top">Credit</td>
                    <td width="20%" align="center" valign="top">Th&eacute;orique</td>
                    <td width="20%" align="center" valign="top">Pratique</td>
                </tr>
            <input name="nombre" type="hidden" class="champ" id="nombre" value="<%=pf.length%>">
            <% 
            double sommeDebit = 0;
            double sommeCredit = 0;
            double sommeDnet = 0;
            for(int i = 0; i < pf.length; i++){
                    sommeDebit += pf[i].getNrdebit();
                    sommeCredit += pf[i].getNrcredit();
                    sommeDnet += pf[i].getSoldepratique();
            %>
            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                <td width="20%" align="center"><%=pf[i].getCaisse()%><input name="caisse<%=i%>" type="hidden" class="champ" id="caisse<%=i%>" value="<%=pf[i].getCaisse()%>">
                </td>
                <td width="20%" style="text-align: right">
                    <input name="report<%=i%>" type="textbox" style="text-align: right" class="champ" id="report<%=i%>" value="<%=pf[i].getReport()%>">
                </td>
                <td width="20%" style="text-align: right">
                    <input name="plafonnement<%=i%>" type="textbox" style="text-align: right" class="champ" id="plafonnement<%=i%>" value="<%=pf[i].getPlafonnement()%>" >
                </td>
                <td width="20%" style="text-align: right">
                    <input name="nrdebit<%=i%>" type="hidden" class="champ" id="nrdebit<%=i%>" value="<%=pf[i].getNrdebit()%>">
                    <a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseNonRapproche.jsp&credit1=0&credit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>" style="text-align: right">
                        <%=Utilitaire.formaterAr(pf[i].getNrdebit())%>
                    </a>
                </td>
                <td width="20%" style="text-align: right">
                    <input name="nrcredit<%=i%>" type="hidden" class="champ" id="nrcredit<%=i%>" value="<%=pf[i].getNrcredit()%>" >
                    <a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseNonRapproche.jsp&debit1=0&debit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>" style="text-align: right">
                        <%=Utilitaire.formaterAr(pf[i].getNrcredit())%>
                    </a>
                </td>
                
                <td width="20%" style="text-align: right">
                    <input name="rdebit<%=i%>" type="hidden" class="champ" id="rdebit<%=i%>" value="<%=pf[i].getRdebit()%>">
                        <%=Utilitaire.formaterAr(pf[i].getRdebit())%>
                </td>
                <td width="20%" style="text-align: right">
                    <input name="rcredit<%=i%>" type="hidden" class="champ" id="rcredit<%=i%>" value="<%=pf[i].getRcredit()%>" >
                        <%=Utilitaire.formaterAr(pf[i].getRcredit())%>
                </td>
                
                <td width="20%" style="text-align: right">
                    <input name="soldetheorique<%=i%>" type="hidden" class="champ" id="soldetheorique<%=i%>" value="<%=pf[i].getSoldetheorique()%>" >
                    <input name="soldetheoriqueF<%=i%>" type="textbox" class="champ" id="soldetheoriqueF<%=i%>" value="<%=Utilitaire.formaterAr(pf[i].getSoldetheorique())%>"readonly>
                </td>
                
                <td width="20%" style="text-align: right">
                    <input name="soldepratique<%=i%>" type="hidden" class="champ" id="soldepratique<%=i%>" value="<%=pf[i].getSoldepratique()%>" >
                    <input name="soldepratiqueF<%=i%>" type="textbox" class="champ" id="soldepratiqueF<%=i%>" value="<%=Utilitaire.formaterAr(pf[i].getSoldepratique())%>"readonly>
                </td>
            </tr>
            <% }%>
            </tbody>
        </table>
        <center>
            <input name="classe" id="classe" type="hidden" value="finance.EtatCaisseGroupe">
			<input name="daty2" id="classe" type="hidden" value="<%=date2%>">
            <input name="bute" id="bute" type="hidden" value="groupeEtatCaisseTableau3.jsp">
            <input name="calculer" type="button" value="calculer" onClick="calculere('<%=pf.length%>')">
            <input name="enregistrer" id="enregistrer" type="submit" value="Enregistrer" onClick="changeActionForm()">
        </center>
        <div id="selectnonee">
            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
                <tbody>
                    <tr class="head">
                        <td width="20%" align="center" valign="top"></td>
                        <td width="20%" align="center" valign="top">Nombre</td>
                        <td width="20%" align="center" valign="top">Somme Depense</td>
                        <td width="20%" align="center" valign="top">Somme Recette</td>
                        <td width="20%" align="center" valign="top">Somme Disponible net</td>
                    </tr>
                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                        <td width="20%" align="center">Total</td>
                        <td width="20%" align="center"><%=Utilitaire.formaterAr(pf.length)%></td>
                        <td width="20%" align="center"><%=Utilitaire.formaterAr(sommeDebit)%></td>
                        <td width="20%" align="center"><%=Utilitaire.formaterAr(sommeCredit)%></td>
                        <td width="20%" align="center"> <input type="text" name="dnet" id="dnet" value="<%=Utilitaire.formaterAr(sommeDnet)%>" /></td>
                    </tr>
                </tbody>
            </table>
        </div>

    
</div>
<p align="center"> <strong> <u>EXPORTER</u> </strong> </p>  
<div style="text-align:left; padding-left: 15px; border: thin solid #0099FF " >
<h3> Format</h3>
<p> csv <input type="radio" name="ext" value="csv" checked="checked" /> </p>
<p> xml <input type="radio" name="ext" value="xml" /> </p>
<p> xls <input type="radio" name="ext" value="xls" /> </p>
<input type="submit" value="Exporter" class="submit" onClick="exporter()" /> 
</form> 
</div>

<script>
    function changeActionForm() {
        document.getElementById('frmListe').action = 'apresEtatCaisseTableau.jsp';
    }
	function exporter() {
        document.getElementById('frmListe').action = '../downloadCaisseGroupe';
    }
</script>