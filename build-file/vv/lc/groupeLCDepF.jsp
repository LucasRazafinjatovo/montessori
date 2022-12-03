<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="finance.*" %>

<%
LigneCreditNature p = new LigneCreditNature();
p.setNomTable("LIGNECREDITNATURE");

String listeCrt[]={"designation","idLigne","mois","annee","libelledir","typeLC","nature", "entite","parution","creditInitial","montantEng","montantVis","montantFac","numcompte"};
String listeInt[]={"mois","parution","creditInitial","montantEng","montantVis","montantFac"};

String colDefaut[]={"idLigne","designation","typeLC","nature","numcompte", "libelledir"};
String somDefaut[]={"creditInitial","montantEng","montantVis","montantFac","reste","impaye"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,6,6);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("lc/groupeLCDepF.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[2]=new Liste("entite",to1,"val","val", true);
Direction to2=new Direction();
to2.setNomTable("direction");
liste[3]=new Liste("libelledir",to2,"libelledir","libelledir");

TypeObjet to3=new TypeObjet();
to3.setNomTable("typelc");
liste[4]=new Liste("typeLC",to3,"val","val", true);

TypeObjet to4=new TypeObjet();
to4.setNomTable("naturelc");
liste[5]=new Liste("nature",to4,"val","val", true);

pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple();

LigneCreditNature[] result = (LigneCreditNature[]) pr.getAllDataNoPagination();

UserEJB u = (UserEJB) session.getAttribute("u");
double[][] listeR =  (double[][]) u.calculResultat(result);
double[][] listeRD =  (double[][]) u.calculResultatRD(result);

 String dateDebut, dateFin, entite, annee;
  entite = request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  annee=request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee= String.valueOf(Utilitaire.getAneeEnCours());
    String debut = Utilitaire.getDebutAnnee(annee);
	String fin = Utilitaire.getFinAnnee(annee);
  dateDebut=Utilitaire.getBorneDatyMoisAnnee(request.getParameter("mois1"), annee)[0] ; if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut=debut;
  dateFin= Utilitaire.getBorneDatyMoisAnnee(request.getParameter("mois2"), annee)[1] ;  if ((dateFin==null)||dateFin.compareTo("")==0) dateFin=fin;
  EtatCaisseReste[] mvtc = u.findEtatCaisseResteMvt(dateDebut,dateFin,"%",entite);
  //Utilitaire.formaterAr(AdminGen.calculSommeDouble(mvtc,6));
%>
<h1>Groupe LC + Resultat</h1>
<form action="<%=pr.getLien()%>?but=lc/groupeLCDepF.jsp" method="post" name="listelc" id="listelc">
<%

out.println(pr.getFormu().getHtml());
out.println(pr.getFormu().getHtmlTri());
out.println(pr.getFormu().makeHtmlButton());
%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=lc/visualiserDetailLC.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=finance/listeMvtCaisse.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=ded/listeOR.jsp"+pr.getFormu().getListeCritereString(),pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]={"idLigne","montantEng","montantVis","montantFac"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<h3 style='text-align:center'>Recette</h3>
<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="20%">Credit Initial</td>
			<td width="20%">Montant Engagé</td>
			<td width="20%">Montant Facture</td>
			<td width="20%">Ecart</td>
			<td width="20%">Impaye</td>
		</tr>
		<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[0][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[0][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[0][2])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[0][3])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[0][4])%></td>
		</tr>
</table>
<br>

<h3 style='text-align:center'>Depense</h3>
<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="20%">Credit Initial</td>
			<td width="20%">Montant Engagé</td>
			<td width="20%">Montant Facture</td>
			<td width="20%">Ecart</td>
			<td width="20%">Impaye</td>
		</tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[1][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[1][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[1][2])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[1][3])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeRD[1][4])%></td>
			</tr>
		</tbody>
</table>
<br>

<h3 style='text-align:center'>Resultat</h3>
<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="33%">Montant Total Recette</td>
			<td width="33%">Montant Total Depense</td>
			<td width="34%">Resultat</td>
		</tr>
			<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[0][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[0][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[0][2])%></td>
			</tr>
</table>
<br>


<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="33%">Montant Recette Normale</td>
			<td width="33%">Montant Depense Fonctionnement</td>
			<td width="34%">Resultat</td>
		</tr>
			<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[1][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[1][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[1][2])%></td>
			</tr>
</table>
<br>

<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="33%">Montant Recette Normale</td>
			<td width="33%">Montant Recette Autre</td>
			<td width="34%">Montant Total Recette</td>
		</tr>
			<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[2][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[2][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[2][2])%></td>
			</tr>
</table>
<br>

<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="33%">Montant Depense Fonctionnement</td>
			<td width="33%">Montant Depense Investissement</td>
			<td width="34%">Montant Total Depense</td>
		</tr>
			<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[3][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[3][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[3][2])%></td>
			</tr>
</table>
<br>

<table width="80%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe" border="1">
		<tr class="head">
			<td width="33%">Total Recette Engagé</td>
			<td width="33%">Total Depense Engagé</td>
			<td width="34%">Etat tresorerie</td>
		</tr>
			<tr>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[4][0])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[4][1])%></td>
				<td align="right"><%=Utilitaire.formaterAr((double)listeR[4][2])%></td>
			</tr>
</table>



<br>
<%


String libEnteteAffiche[] = {"idLigne", "Designation", "Type LC", "Nature",  "N° compte", "Direction", 
"Credit initial",  "Montant Engage", "Montant Vise", "Montant facture", "Reste (credit - facture)", "Impaye"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
