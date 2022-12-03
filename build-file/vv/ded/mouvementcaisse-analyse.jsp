<%-- 
    Document   : mouvementcaisse-analyse
    Created on : 17 mai 2017, 11:09:41
    Author     : Doudou Tiarilala
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="ded.AnalyseMVTCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%
    AnalyseMVTCaisse p = new AnalyseMVTCaisse();
    int annee = Utilitaire.getAneeEnCours();
    String listeCrt[] = {"daty"};
    String listeInt[] = {"daty"};
    PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setLien("../"+pr.getLien());
    pr.setApres("ded/mouvementcaisse-analyse.jsp");
    String aw="";
    if(request.getParameter("daty1")==null &&request.getParameter("daty2")==null){
         pr.getFormu().getChamp("daty1").setDefaut("01/01/"+Utilitaire.getAneeEnCours());
         pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    
        aw+=" and daty>='"+"01/01/"+Utilitaire.getAneeEnCours()+"' and daty<='"+Utilitaire.dateDuJour()+"' and annee = '"+Utilitaire.getAneeEnCours()+"'";
    }
    else{
        if(request.getParameter("annee")!=null)
            annee = Utilitaire.stringToInt(request.getParameter("annee"));
        else if(request.getParameter("daty1")!=null)
            annee = Integer.valueOf(Utilitaire.getAnnee(request.getParameter("daty1")));
        else 
            annee = Integer.valueOf(Utilitaire.getAnnee(request.getParameter("daty2")));
    }
    
    aw += " and annee='"+annee+"'";
    aw += " order by daty asc";
    pr.setAWhere(aw);    
    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date min ");
    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date max ");
    String libEntete[] = {"daty"};
    String[] colSomme = null;
    double report = 0;
    pr.setNpp(100);
    pr.creerObjetPage(libEntete, colSomme);
    AnalyseMVTCaisse[] op = (AnalyseMVTCaisse[]) pr.getRs().getResultat();
    if (request.getParameter("repport") != null) {
        report = Utilitaire.stringToDouble(request.getParameter("repport"));
    }
    p.traiterCumul(op, report);
    
%>
<h1>Etat de prevision</h1>
<form action="mouvementcaisse-analyse.jsp" method="post" name="listeParution" id="listeParution">
    
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tbody>
            <tr>
                <td align="left" class="left">Date min </td>
                <td align="center" class="champ"><input name="daty1" type="textbox" class="champ" id="daty1" value="<%="01/01/"+Utilitaire.getAneeEnCours()%>"></td>
                <td></td>
                <td align="left" class="left">Date max </td>
                <td align="center" class="champ"><input name="daty2" type="textbox" class="champ" id="daty2" value="<%=Utilitaire.dateDuJour()%>"></td>
                <td></td>
                <td align="left" class="left">Annee</td>
                <td align="center" class="champ"><input name="annee" type="textbox" class="champ" id="annee" value="<%=Utilitaire.getAneeEnCours()%>"></td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tbody>
            <tr>
                <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit"></td>
                <td align="center"> <input type="reset" name="Submit" value="Annuler" class="submit"></td>
            </tr>
        </tbody>
    </table>
    
    <br/> 
    Report: <input type="text" value="<%=report%>" name="repport">
</form>
<br> 
<%
        out.println(pr.getTableauRecap().getHtml());%><br> 
        
<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="1" style="border-collapse: collapse">
    <thead>
        <tr class="head">
            <th rowspan="2" >Date</th>
          
            <th colspan="3">OP</th>
            <th colspan="3">OR</th>
            <th colspan="2">Solde</th>
            <th colspan="2">Cumul</th>
        </tr>
        <tr class="head">
            <th>Montant</th>
            <th>Payé</th>
            <th >Reste</th>
            <th>Montant</th>
            <th>Payé</th>
            <th >Reste</th>
            <th>Prevu</th>
            <th>Pratique</th>
            <th>Prevu</th>
            <th>Pratique</th>
        </tr>
    </thead>
    <tbody>
        <%for (int i = 0; i < op.length; i++) {%>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
            <td><%=Utilitaire.formatterDaty(op[i].getDaty())%></td>
          
            <td style="text-align: right"><a href="<%=pr.getLien()%>?but=ded/listeOP.jsp&etat=Oppayelc_tdp&daty1=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>&daty2=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>&annee=<%=Utilitaire.getAnnee(op[i].getDaty())%>"><%=Utilitaire.formaterAr(op[i].getMontantop())%></a></td>
            <td style="text-align: right"><a href="<%=pr.getLien()%>?but=finance/listeMvtCaisseSansLc.jsp&daty1=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>&daty2=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>"><%=Utilitaire.formaterAr(op[i].getOppaye())%></a></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getOpreste())%></td>
            <td style="text-align: right"><a href="<%=pr.getLien()%>?but=ded/listeOR_o.jsp&etat=orpayelc&daty1=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>&daty2=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>"><%=Utilitaire.formaterAr(op[i].getMontantor())%></a></td>
            <td style="text-align: right"><a href="<%=pr.getLien()%>?but=finance/listeMvtCaisseSansLc.jsp&daty1=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>&daty2=<%=Utilitaire.formatterDaty(op[i].getDaty()) %>"><%=Utilitaire.formaterAr(op[i].getOrpaye())%></a></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getOrreste())%></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getPrevu())%></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getPratique())%></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getPrevucumul())%></td>
            <td style="text-align: right"><%=Utilitaire.formaterAr(op[i].getPratiquecumul())%></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%out.println(pr.getBasPageSansLien());%>