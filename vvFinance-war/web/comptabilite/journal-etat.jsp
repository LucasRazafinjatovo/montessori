<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>

<%
EcritureLibelle p = new EcritureLibelle();
p.setNomTable("journal_compta");
String listeCrt[]={"mois","annee","exercice","societe","codejournal", "compte", "comptetiers", "libelle", "numpiece", "numero"};
String listeInt[]={"numero"};
String libEntete[]={"JOUR","NUMERO","COMPTE", "COMPTETIERS", "NUMPIECE", "LIBELLE", "ECHEANCE", "MONTANTDEBIT", "MONTANTCREDIT"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2, libEntete,  9);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[2];

TypeObjet journal = new TypeObjet();
journal.setNomTable("JOURNALCOMPTA");
liste[0] = new Liste("codejournal", journal, "DESCE", "desce");
Societe to1=new Societe();
liste[1]=new Liste("societe",to1,"nom","nom");
pr.getFormu().changerEnChamp(liste);
    
pr.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr.getFormu().getChamp("codejournal").setLibelle("Journal");
pr.getFormu().getChamp("compte").setLibelle("Compte");
pr.getFormu().getChamp("compte").setPageAppel("comptabilite/choixCompte.jsp");
pr.getFormu().getChamp("comptetiers").setLibelle("Compte tiers");
pr.getFormu().getChamp("comptetiers").setPageAppel("comptabilite/choixCompteTiers.jsp");
pr.getFormu().getChamp("libelle").setLibelle("Libell&eacute;");
pr.getFormu().getChamp("numpiece").setLibelle("N° pi&egrave;ce");
pr.getFormu().getChamp("numero1").setLibelle("Num&eacute;ro (min)");
pr.getFormu().getChamp("numero2").setLibelle("Num&eacute;ro (max)");

pr.setApres("comptabilite/journal-etat.jsp");

String colSomme[]={"MONTANTDEBIT", "MONTANTCREDIT"};
pr.creerObjetPageMultiple(libEntete,colSomme);

EcritureLibelle[] listeR = (EcritureLibelle[]) pr.getRs().getResultat();

%>
<h1>Journal</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/journal-etat.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">Jour</td>
<td width=7% align="center" valign="top">N° ecriture</td>
<td width=15% align="center" valign="top">Compte</td>
<td width=10% align="center" valign="top">Compte tiers</td>
<td width=10% align="center" valign="top">N° piece</td>
<td width=10% align="center" valign="top">Libelle</td>
<td width=10% align="center" valign="top">Echeance</td>
<td width=10% align="center" valign="top">Montant d&eacute;bit</td>
<td width=10% align="center" valign="top">Montant cr&eacute;dit</td>
</tr>

<%
for(int i=0;i<listeR.length;i++)
{
	String typetiers= "";
	int cpttiers = 0;
	if (listeR[i].getComptetiers() != null) {
		char[] entab = listeR[i].getComptetiers().toCharArray();
		typetiers = String.valueOf(entab[0]);
		String nbtoint = Utilitaire.split(listeR[i].getComptetiers(),typetiers)[0];
		while (nbtoint.startsWith("0")){
			char[] dist = new char[nbtoint.length()-1];
			nbtoint.getChars(1, nbtoint.length(), dist, 0);
			nbtoint = new String(dist);
		}
		cpttiers = Utilitaire.stringToInt(nbtoint);
	}
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><%=listeR[i].getJour() %></td>
<td align=center><a href=<%=pr.getLien()%>?but=comptabilite/ecriture-fiche.jsp&numero=<%=listeR[i].getNumero()%>><%=listeR[i].getNumero() %></a></td>
<td align=center><a href=<%=pr.getLien()%>?but=comptabilite/balance-etat.jsp&compte1=<%=listeR[i].getCompte()%>&compte2=<%=listeR[i].getCompte()%>&exercice=<%=listeR[i].getExercice()%>><%=listeR[i].getCompte() %></a></td>
<td align=center>
	<% if (listeR[i].getComptetiers() != null) {%>
	<a href=<%=pr.getLien()%>?but=comptabilite/balancetiers-etat.jsp&typetiers=<%=typetiers%>&compte1=<%=cpttiers%>&compte2=<%=cpttiers%>&exercice=<%=listeR[i].getExercice()%>><%=listeR[i].getComptetiers()%></a>
	<% } %>
</td>
<td align=right><%=Utilitaire.champNull(listeR[i].getNumpiece())%></td>
<td align=right><%=Utilitaire.champNull(listeR[i].getLibelle())%></td>
<td align=right><%if (listeR[i].getEcheance()!= null) out.print(Utilitaire.datetostring(listeR[i].getEcheance()));%></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getMontantdebit()) %></td>
<td align=right><%=Utilitaire.formaterAr(listeR[i].getMontantcredit()) %></td>
</tr>
<%}%>
</table>
<br>
<%
out.println(pr.getBasPage());
%>