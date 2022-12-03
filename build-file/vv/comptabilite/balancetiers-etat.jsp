<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
BalanceTiers p=new BalanceTiers();
p.setNomTable("balancetiers_groupe_libelle");
String listeCrt[]={"exercice","typetiers", "compte", "intitule","daty","echeance"};
String listeInt[]={"compte","daty", "echeance"};

String colDefaut[]={"exercice", "societe","comptetiers", "intitule"};
String somDefaut[]={"initdebit","initcredit", "mvtdebit", "mvtcredit", "soldedebit", "soldecredit"};

PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,4,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("comptabilite/balancetiers-etat.jsp");

pr.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr.getFormu().getChamp("typetiers").setLibelle("Type tiers");
pr.getFormu().getChamp("compte1").setLibelle("Compte (min)");
pr.getFormu().getChamp("compte2").setLibelle("Compte (max)");
pr.getFormu().getChamp("daty1").setLibelle("Date (min)");
pr.getFormu().getChamp("daty2").setLibelle("Date (max)");
pr.getFormu().getChamp("echeance1").setLibelle("Ech&eacute;ance (min)");
pr.getFormu().getChamp("echeance2").setLibelle("Ech&eacute;ance (max)");

pr.setNpp(100);
pr.creerObjetPageMultiple();

BalanceTiers[] result = (BalanceTiers[]) pr.getRs().getResultat();
String daty1 = request.getParameter("daty1");

UserEJB u = (UserEJB) session.getAttribute("u");
BalanceTiers[] listeR =  (BalanceTiers[]) u.setInitSoldeBalanceTiers(result, daty1);
double[] sommes = (double[]) u.calculSommeInit((Balance[])listeR);

double[] rec = pr.getRs().getSommeEtNombre();
rec[1] = sommes[0]; rec[2] = sommes[1];
pr.getRs().setSommeEtNombre(rec);
String[][] datadirect = pr.getTableauRecap().getDataDirecte();
datadirect[0][2] = Utilitaire.formaterAr(sommes[0]); datadirect[0][3] = Utilitaire.formaterAr(sommes[1]);
datadirect[0][6] = Utilitaire.formaterAr(sommes[2]); datadirect[0][7] = Utilitaire.formaterAr(sommes[3]);

pr.getTableauRecap().setDataDirecte(datadirect);


%>
<h1>Balance tiers</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/balancetiers-etat.jsp" method="post" name="listeopg" id="listeopg">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>

</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">Soci&eacute;t&eacute;</td>
<td width=7% align="center" valign="top">Compte Tiers</td>
<td width=15% align=center valign=top>Nom</td>
<td width=10% align=center valign=top>Solde initial d&eacute;bit</td>
<td width=10% align=center valign=top>Solde initial cr&eacute;dit</td>
<td width=10% align=center valign=top>D&eacute;bit</td>
<td width=10% align=center valign=top>Cr&eacute;dit</td>
<td width=10% align=center valign=top>Solde final d&eacute;biteur</td>
<td width=10% align=center valign=top>Solde final cr&eacute;diteur</td>
</tr>

<%
for(int i=0;i<listeR.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><%=listeR[i].getSociete() %></td>
<td align=center><a href=<%=pr.getLien()%>?but=comptabilite/grandlivre-complet.jsp&exercice=<%=listeR[i].getExercice()%>&comptetiers=<%=listeR[i].getComptetiers()%>><%=listeR[i].getComptetiers() %></a></td>
<td align=center><%=listeR[i].getIntitule() %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getInitdebit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getInitcredit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getMvtdebit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getMvtcredit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getSoldedebit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getSoldecredit()) %></td>
</tr>
<%}%>
</table>
<br>
<%
out.println(pr.getBasPage());
%>
