<%@ page import="finance.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%
  EtatDeCaisse p = new EtatDeCaisse();
  String listeCrt[]={"caisse","daty","credit_caisse","debit_caisse","soldec","debit_rib","credit_rib","solde_rib","debit_theorique","credit_theorique","debit_non_rapprocherib","credit_non_rapprocherib"};
  String listeInt[]={"daty","credit_caisse","debit_caisse","soldec","debit_rib","credit_rib","solde_rib","debit_theorique","credit_theorique","debit_non_rapprocherib","credit_non_rapprocherib"};
  PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,6);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.getFormu().getChamp("daty1").setLibelle("Date min");
  pr.getFormu().getChamp("daty2").setLibelle("Date max");
  pr.getFormu().getChamp("credit_caisse1").setLibelle("credit caisse min)");
  pr.getFormu().getChamp("credit_caisse2").setLibelle("credit caisse max");
  pr.getFormu().getChamp("debit_caisse1").setLibelle("debit caisse min");
  pr.getFormu().getChamp("debit_caisse2").setLibelle("debit caisse max");
  pr.getFormu().getChamp("soldec1").setLibelle("solde caisse min)");
  pr.getFormu().getChamp("soldec2").setLibelle("solde caisse max");
  pr.getFormu().getChamp("debit_rib1").setLibelle("debit RIB min)");
  pr.getFormu().getChamp("debit_rib2").setLibelle("debit RIB max");
  pr.getFormu().getChamp("credit_rib1").setLibelle("credit RIB min");
  pr.getFormu().getChamp("credit_rib2").setLibelle("credit RIB max");
  pr.getFormu().getChamp("debit_theorique1").setLibelle("debit theorique NR min)");
  pr.getFormu().getChamp("debit_theorique2").setLibelle("debit theorique NR max");
  pr.getFormu().getChamp("debit_non_rapprocherib1").setLibelle("debit RIB NR  min)");
  pr.getFormu().getChamp("debit_non_rapprocherib2").setLibelle("debit RIB NR max");
  pr.getFormu().getChamp("credit_non_rapprocherib1").setLibelle("credit RIB NR  min)");
  pr.getFormu().getChamp("credit_non_rapprocherib2").setLibelle("credit RIB NR max");
  pr.setApres("finance/etatDeCaisse.jsp");
  String libEntete[]={"caisse","daty","credit_caisse","debit_caisse","soldec","debit_rib","credit_rib","solde_rib","debit_theorique","credit_theorique","debit_non_rapprocherib","credit_non_rapprocherib","solde"};

  String colSomme[]=null;
  pr.creerObjetPage(libEntete,colSomme);
  EtatDeCaisse [] liste=(EtatDeCaisse [])pr.getTableau().getData();
%>
<h1>Etat de Caisse</h1>
<form action="http://laptopdga:8080/vv/finance/etatDeCaisse.jsp" method="post" name="listePub" id="listePub">
<%out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<table class="monographe" border="1" style="border-collapse: collapse;">
  <tr>
	<th rowspan="2">nom Caisse</th>
	<th rowspan="2">Date</th>
    <th colspan="3">Caisse</th>
    <th colspan="3">RIB</th>
    <th colspan="3">Th&eacute;orique NR</th>
    <th colspan="3">RIB NR</th>
  </tr>
  <tr>
    <th>D&eacute;bit</th>
    <th>Cr&eacute;dit</th>
    <th>Solde</th>

    <th>D&eacute;bit</th>
    <th>Cr&eacute;dit</th>
    <th>Solde</th>

    <th>D&eacute;bit</th>
    <th>Cr&eacute;dit</th>
    <th>Solde</th>

    <th>D&eacute;bit</th>
    <th>Cr&eacute;dit</th>
    <th>Solde</th>
  </tr>
  <%for (int i = 0; i < liste.length; i++) {%>
	<tr>
		<td align="left"><% out.print(liste[i].getCaisse());%></td>
		<td align="right"><% out.print(Utilitaire.formatterDaty(liste[i].getDaty()));%></td>

		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getDebit_caisse()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getCredit_caisse()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getSoldec()));%></td>

		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getDebit_rib()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getCredit_rib()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getSolde_rib()));%></td>

		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getDebit_theorique()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getCredit_theorique()));%></td>
                <td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getCredit_theorique() - liste[i].getDebit_theorique()));%></td>

		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getDebit_non_rapprocherib()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getCredit_non_rapprocherib()));%></td>
		<td align="right"><%out.print(Utilitaire.formaterAr(liste[i].getSolde()));%></td>
	</tr>
	<%}%>
</table>
