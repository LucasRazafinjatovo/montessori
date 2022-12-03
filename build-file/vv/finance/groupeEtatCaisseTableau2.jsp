<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
EtatCaisseTableau p;
String date2 = Utilitaire.dateDuJour();
String date1 = Utilitaire.dateDuJour();
String date3 = Utilitaire.dateDuJour();
%>
<%
p = new EtatCaisseTableau();
String etat = "ETATCAISSETABLEAUNEW";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
        etat = request.getParameter("etat");
p.setNomTable("ETATCAISSETABLEAUNEW");
String listeCrt[] = {"daty","caisse","debit","credit"};
String listeInt[] = {"daty","debit","credit"};

String colDefaut[]={"caisse"};
String somDefaut[]={"report","debit","credit","disponiblenet"};
String moyenneDefaut[]={"plafonnement"};
PageRechercheGroupe pr = new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,moyenneDefaut,6,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("groupeEtatCaisseTableau2.jsp");
affichage.Champ[] liste = new affichage.Champ[1];
Caisse to = new Caisse();
to.setNomTable("caisse");
liste[0] = new Liste("caisse",to,"descCaisse","descCaisse", true);
pr.getFormu().changerEnChamp(liste);
pr.setNpp(400);
pr.creerObjetPageMoyenne();
EtatCaisseTableau[] list = (EtatCaisseTableau[])pr.getRs().getResultat();
EtatCaisseTableau temp = new EtatCaisseTableau();
date1 = (request.getParameter("daty1") == null || request.getParameter("daty1").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty1");
date2 = (request.getParameter("daty2") == null || request.getParameter("daty2").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty2");
date3 = (request.getParameter("daty3") == null || request.getParameter("daty3").compareToIgnoreCase("") == 0)? Utilitaire.dateDuJour(): request.getParameter("daty3");

EtatCaisseTableau[] pf = temp.calculer(list, date1, date2, date3);

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
            var debit = document.getElementById("debitcol" + c).value;
            var credit = document.getElementById("creditcol" + c).value;
			
            var plafonnement = document.getElementById("plafonnement" + c).value;

            var disp = (parseFloat(credit) + parseFloat(report) + parseFloat(plafonnement)) - parseFloat(debit);
            dnet += (parseFloat(credit) + parseFloat(report) + parseFloat(plafonnement)) - parseFloat(debit);
            var disponible = disp.toFixed(2);
            document.getElementById("disponiblee" + c).value = disponible;
            for (var i = 0; i < Math.floor((disponible.length - (1 + i)) / 3); i++) {
                disponible = disponible.substring(0, disponible.length - (4 * i + 3)) + ' ' + disponible.substring(disponible.length - (4 * i + 3));
            }
            document.getElementById("disponiblenet" + c).value = disponible;

            report = 0;
            debit = 0;
            credit = 0;
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
<form action="groupeEtatCaisseTableau2.jsp" method="post" name="groupePrev" id="groupePrev">
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
            <tr>
                <td align="left" class="left">daty3</td>
                <td align="center" class="champ"><input name="daty3" type="textbox" class="champ" id="daty3" ></td>
                <td></td>
                <td align="left" class="left">daty4</td>
                <td align="center" class="champ"><input name="daty4" type="textbox" class="champ" id="daty4" value=""></td>
                <td></td>
            </tr>
            <tr><td align="left" class="left">caisse</td><td align="center" class="champ"><select name="caisse" class="champ" id="caisse" multiple=""><option value="%">Tous</option><option value="airtel money">airtel money</option><option value="BFV ITU">BFV ITU</option><option value="BGFI VV">BGFI VV</option><option value="BMOI VV">BMOI VV</option><option value="BNI activa">BNI activa</option><option value="BNI BICI">BNI BICI</option><option value="BNI ITU ">BNI ITU </option><option value="BNI Tanj VV">BNI Tanj VV</option><option value="BOA Activa">BOA Activa</option><option value="Boa VV">Boa VV</option><option value="C Foire">C Foire</option><option value="C Hary VV">C Hary VV</option><option value="Caisse ITU">Caisse ITU</option><option value="caisse mvola">caisse mvola</option><option value="Euro">Euro</option><option value="Mvola   commerciale  ">Mvola   commerciale  </option><option value="Mvola ITU">Mvola ITU</option><option value="orange commercial">orange commercial</option><option value="orange dist">orange dist</option><option value="orange ITU">orange ITU</option><option value="Rand">Rand</option><option value="Sud Afrique">Sud Afrique</option></select></td><td></td><td align="left" class="left">debit1</td><td align="center" class="champ"><input name="debit1" type="textbox" class="champ" id="debit1" value=""></td><td></td></tr>
            <tr><td align="left" class="left">debit2</td><td align="center" class="champ"><input name="debit2" type="textbox" class="champ" id="debit2" value=""></td><td></td><td align="left" class="left">credit1</td><td align="center" class="champ"><input name="credit1" type="textbox" class="champ" id="credit1" value=""></td><td></td></tr>
            <tr><td align="left" class="left">credit2</td><td align="center" class="champ"><input name="credit2" type="textbox" class="champ" id="credit2" value=""></td><td></td></tr>
        </tbody>
    </table>

    <br><strong><font color="#FF0000" size="1">TRIER PAR </font></strong>
    <table width="100%">
        <tbody>
            <tr></tr>
            <tr><td> Colonne </td><td><select name="colonne" class="champ" id="colonne"><option value="daty" selected="">daty</option><option value="devise">devise</option><option value="caisse">caisse</option><option value="debit">debit</option><option value="credit">credit</option><option value="montantbrut">montantbrut</option><option value="plafonnement">plafonnement</option><option value="report">report</option><option value="disponiblenet">disponiblenet</option></select></td><td> Ordre </td><td><select name="ordre" class="champ" id="ordre"><option value="DESC" selected="">DESC</option><option value="ASC">ASC</option></select></td></tr>
        </tbody>
    </table>

    <br><table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit"></td><td align="center"> <input type="reset" name="Submit" value="annuler" class="submit"></td></tr></tbody></table>
    <br/>
    <center>etat : 	<select name="etat" class="champ" id="etat" >
            <option value="MONTANTCAISSEINDISPONIBLE"  <%if(etat.compareTo("MONTANTCAISSEINDISPONIBLE")==0) out.println("selected");%>> tous </option>
            <option value="ETATCAISSETABLEAUNEW"  <%if(etat.compareTo("ETATCAISSETABLEAUNEW")==0) out.println("selected");%>>exclure debit & credit indisponible</option>
        </select></center>
</form>

<br>
<div id="selectnonee">
    <form action="groupeEtatCaisseTableau2.jsp" method="POST" name="frmListe" id="frmListe">
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
            <tbody>
                <tr class="head">
                    <td width="20%" align="center" valign="top"></td>
                    <td width="20%" align="center" valign="top"></td>
                    <td colspan="2" align="center" valign="top">Cheque non rapproch&eacute;</td>
                    <td width="20%" align="center" valign="top"></td>
                    <td width="20%" align="center" valign="top"></td>
                </tr>
                <tr class="head">
                    <td width="20%" align="center" valign="top">Caisse</td>
                    <td width="20%" align="center" valign="top">Report</td>
                    <td width="20%" align="center" valign="top">Depense</td>
                    <td width="20%" align="center" valign="top">Recette</td>
                    <td width="20%" align="center" valign="top">Disponiblenet</td>
                    <td width="20%" align="center" valign="top">Plafonnement</td>
                </tr>
            <input name="nombre" type="hidden" class="champ" id="nombre" value="<%=pf.length%>">
            <% 
            double sommeDebit = 0;
            double sommeCredit = 0;
            double sommeDnet = 0;
            for(int i = 0; i < pf.length; i++){
                    sommeDebit += pf[i].getDebit();
                    sommeCredit += pf[i].getCredit();
                    sommeDnet += pf[i].getDisponiblenet();
            %>
            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                <td width="20%" align="center"><%=pf[i].getCaisse()%><input name="caisse<%=i%>" type="hidden" class="champ" id="caisse<%=i%>" value="<%=pf[i].getCaisse()%>">
                </td>
                <td width="20%" align="center">
                    <input name="report<%=i%>" type="textbox" class="champ" id="report<%=i%>" value="<%=pf[i].getReport()%>">
                </td>
                <td width="20%" align="center">
                    <input name="debit<%=i%>" type="hidden" class="champ" id="debitcol<%=i%>" value="<%=pf[i].getDebit()%>">
                    <a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseNonRapproche.jsp&credit1=0&credit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>">
                        <%=Utilitaire.formaterAr(pf[i].getDebit())%>
                    </a>
                </td>
                <td width="20%" align="center">
                    <input name="credit<%=i%>" type="hidden" class="champ" id="creditcol<%=i%>" value="<%=pf[i].getCredit()%>" >
                    <a href="../modeleAdmin.jsp?but=finance/listeMvtCaisseNonRapproche.jsp&debit1=0&debit2=0&daty1=<%=request.getParameter("daty1")%>&daty2=<%=date2%>&idcaisse=<%=pf[i].getCaisse()%>">
                        <%=Utilitaire.formaterAr(pf[i].getCredit())%>
                    </a>
                </td>
                <td width="20%" align="center">
                    <input name="disponiblee<%=i%>" type="textbox" class="champ" id="disponiblee<%=i%>" value="<%=pf[i].getDisponiblenet()%>">
                    <input name="disponiblenet<%=i%>" type="textbox" class="champ" id="disponiblenet<%=i%>" value="<%=Utilitaire.formaterAr(pf[i].getDisponiblenet())%>"readonly>
                </td>
                <td width="20%" align="center">
                    <input name="plafonnement<%=i%>" type="textbox" class="champ" id="plafonnement<%=i%>" value="<%=pf[i].getPlafonnement()%>" ></td>
            </tr>
            <% }%>
            </tbody>
        </table>
        <center>
            <input name="classe" id="classe" type="hidden" value="finance.EtatCaisseTableau2">
			<input name="daty2" id="classe" type="hidden" value="<%=date2%>">
            <input name="bute" id="bute" type="hidden" value="groupeEtatCaisseTableau2.jsp">
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


    <% if(etat.compareToIgnoreCase("MONTANTCAISSEINDISPONIBLE") == 0){
            EtatCaisseTableau tempin = new EtatCaisseTableau();
            tempin.setNomTable("MONTANTCAISSEINDISPONIBLE");
            String somDefaut2[]={"debit","credit"};
            PageRechercheGroupe prin = new PageRechercheGroupe(tempin,request,listeCrt,listeInt,2,colDefaut,somDefaut2,moyenneDefaut,6,2);
            prin.setUtilisateur((user.UserEJB)session.getValue("u"));
            prin.creerObjetPage();
            EtatCaisseTableau[] listin = (EtatCaisseTableau[])prin.getRs().getResultat();
            EtatCaisseTableau[] pfin = temp.calculer(listin, request.getParameter("daty1"));
    %>
    <h1>Montant indisponible</h1>
    <%
	out.println(prin.getTableauRecap().getHtml());%>
    <br>
    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
        <tbody>
            <tr class="head">
                <td width="20%" align="center" valign="top">Caisse</td>
                <td width="20%" align="center" valign="top">Debit</td>
                <td width="20%" align="center" valign="top">Credit</td>
            </tr>
            <% for(int k = 0; k < pfin.length; k++){%>
            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                <td width="20%" align="center"><%=pfin[k].getCaisse()%></td>
                <td width="20%" align="center"><%=Utilitaire.formaterAr(pfin[k].getDebit())%></td>
                <td width="20%" align="center"><%=Utilitaire.formaterAr(pfin[k].getCredit())%></td>
            </tr>
            <% }%>
        </tbody>
    </table>
    <%}%>
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
