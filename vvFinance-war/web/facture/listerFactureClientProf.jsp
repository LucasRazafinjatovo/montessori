<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>


<%!
	FactureFournisseur p;
	bean.Champ []nomC;
	%>
	<%
	p=new FactureFournisseur();
	nomC=ListeColonneTable.getFromListe(p,null);
	String etat="factureclientprof";
	if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
		etat=request.getParameter("etat");
	p.setNomTable(etat);
	String listeCrt[]={"idFactureFournisseur","daty","designation","idFournisseur","montantTTC","resp","numFact"};
	String listeInt[]={"daty"};
	String libEntete[]={"idFactureFournisseur","daty","designation","idFournisseur","montantTTC","resp"};
	PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,6);

	pr.setUtilisateur((user.UserEJB)session.getValue("u"));
	pr.setLien((String)session.getValue("lien"));
	pr.setApres("facture/listerFactureClientProf.jsp");
	affichage.Champ[] liste=new affichage.Champ[1];
	TypeObjet to1=new TypeObjet();
	to1.setNomTable("agence");
	liste[0]=new Liste("resp",to1,"val","val");
	((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantTtc");
	pr.getFormu().changerEnChamp(liste);
	String colSomme[]=null;
	pr.setNpp(100);
	pr.creerObjetPage(libEntete,colSomme);

	%>
<h1>Lister les factures proforma </h1>
<form action="<%=pr.getLien()%>?but=facture/listerFactureClientProf.jsp" method="post" name="listePub" id="listePub">
	<%
	out.println(pr.getFormu().getHtmlEnsemble());%>
	etat : <select name="etat" class="champ" id="etat" >
		<option value="factureclientprof">Tous</option>
        <option value="factureclientproformaaviser"  <%if(etat.compareTo("factureclientproformaaviser")==0) out.println("selected");%>>a viser</option>
        <option value="factureclientproformaviser"  <%if(etat.compareTo("factureclientproformaviser")==0) out.println("selected");%>>viser</option>
	</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[] = {pr.getLien()+"?but=facture/visualiserFactureClientProforma.jsp"};
String colonneLien[] = {"idFactureFournisseur"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
