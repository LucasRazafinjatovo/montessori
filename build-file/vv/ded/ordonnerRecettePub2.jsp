<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OpLcComplet" %>
<%@ page import="lc.Direction" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres="ded/apresOrdonnerRecette.jsp";
	String lien= null;
	facture.Client clt[] = null;
	UserEJB u = null;
	TypeObjet tyo[] = null;
	TypeObjet dev[] = null;
	TypeObjet mp[] =null;
	TypeObjet source[] =null;
	TypeObjet ag[] =null;
	Caisse caiss[] = null;
	String idFact = null;
	facture.Tva tva = null;
	String nature=null;
	String numObjet = null;
	String typeObjet = null;
	String idLigne= null;
	String montant = null;
     %>
	<%
	idFact=request.getParameter("idFacture");
	typeObjet=request.getParameter("typeObjet");
	numObjet=request.getParameter("numObjet");if (numObjet==null) numObjet="";
	idLigne =request.getParameter("idLigne");
	nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
	if(idFact == null) idFact = "";
	try{
		u=(user.UserEJB)session.getValue("u");
		lien=(String)session.getValue("lien");
		out.println("lien = "+lien);
		dev = u.findTypeObjet("Devise","%","%");
		ag = u.findTypeObjet("Agence","%","%");

		String idmontant = (String)session.getValue("pub");
		session.removeAttribute("listepub");
		session.setAttribute("listepub",idmontant);
		
		
		OpLcComplet p=new OpLcComplet();
		String etat="ORVISENONPAYELC_COMM";
		p.setNomTable(etat);
		String listeCrt[] = {"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant","paye","idFournisseur"};
		String listeInt[] = {"mois","daty","montant","paye"};
		String libEntete[] = {"id","daty","ded_id","idLigne","montant","remarque","paye"};
		PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
		pr.setUtilisateur((user.UserEJB)session.getValue("u"));
		pr.setLien((String)session.getValue("lien"));
		pr.setApres("ded/ordonnerRecettePub2.jsp");
		affichage.Champ[] liste=new affichage.Champ[6];

		TypeObjet to=new TypeObjet();
		to.setNomTable("typeentree");
		liste[0]=new Liste("idTypeLigne",to,"val","val");
		TypeObjet to1=new TypeObjet();
		to1.setNomTable("beneficiaire");
		liste[1]=new Liste("identite",to1,"val","val");
		Direction to2=new Direction();
		to2.setNomTable("direction");
		liste[2]=new Liste("iddirection",to2,"libelledir","libelledir");
		liste[3]=new Liste("mois1");
		((Liste)(liste[3])).makeListeMois();
		liste[4]=new Liste("mois2");
		((Liste)(liste[4])).makeListeMois();
		TypeObjet to5=new TypeObjet();
		to5.setNomTable("agence");
		liste[5]=new Liste("numCompte",to5,"val","val");
		
				
		pr.getFormu().changerEnChamp(liste);
		pr.getFormu().setLibelleAffiche("Agence",8);
		String colSomme[]={"montant","paye","parution"};
		pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
		pr.creerObjetPageMultiple(libEntete,colSomme);
		
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Liste Ordre recette </h1>
<form action="<%=pr.getLien()%>?but=ded/ordonnerRecettePub2.jsp" method="post" name="listePub" id="listePub">
<%
	
	out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
	
	String lienTableau[]={pr.getLien()+"?but=ded/visualiserOR.jsp",pr.getLien()+"?but=facture/visualiserFactureClient.jsp",pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"};
	String colonneLien[]={"id","ded_id","idLigne"};
	pr.getTableau().setLien(lienTableau);
	pr.getTableau().setColonneLien(colonneLien);
	String attLien[] = {"idOP","idBC","numObjet"};
	pr.getTableau().setAttLien(attLien);
	out.println(pr.getTableauRecap().getHtml());%>
	<br>
	<form action="<%=pr.getLien()%>?but=ded/liaisonORpub.jsp" method="post">
		<%
		out.println(pr.getTableau().getHtmlWithRadio());
		%>
		<input type="hidden" name="type" value="pub" class="submit">
		<input type="submit"  value="Valider" class="submit">
	</form>
	<% out.println(pr.getBasPage());%>
<div align="center">
	<script language="javascript">
	var cal1 = new calendar1(document.forms['recette'].elements['daty']);
	cal1.year_scroll = false;
	cal1.time_comp = false;
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>
  <%
  }catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>