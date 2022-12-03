<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="facture.*" %>
<%
try
{
	Pucomplet p=new Pucomplet();
	String etat = "PUBCOMPLETCLOTURENONPAYE";
	p.setNomTable(etat);
	String listeCrt[]={"id","idclient","idCat","libAgence","designation","libJournal","idMont","couleur","numParution","pagemisyazy","formulaire","montantVal","datyparution"};
	String listeInt[]={"numParution","pagemisyazy","formulaire","montantVal","datyparution"};
	String libEntete[]={"id","libClient","idMont","numParution","datyParution","montantVal","libAgence"};
	PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
	pr.setUtilisateur((user.UserEJB)session.getValue("u"));
	pr.setLien((String)session.getValue("lien"));
	pr.setApres("pub/listePub_cnp.jsp");
	affichage.Champ[] liste=new affichage.Champ[2];
	TypeObjet to=new TypeObjet();
	to.setNomTable("categoriePub");
	liste[0]=new Liste("idCat",to);
	Client to1=new Client();
	to1.setNomTable("client");
	liste[1]=new Liste("idclient",to1,"nom","idclient");
	pr.getFormu().changerEnChamp(liste);
	pr.getFormu().setLibelleAffiche("format",6);
	pr.getFormu().getChamp("idclient").setLibelle("client");
	//String libAffiche[]={"id","libClient","format","numParution","datyParution","montantVal","libAgence"};
	String colSomme[]={"montantVal"};
	pr.creerObjetPage(libEntete,colSomme);
	//Pucomplet[] pf=(Pucomplet[])pr.getRs().getResultat();
	//pr.getTableau().setLibelleAffiche(libAffiche);
%>
<h1>Liste des pubicites clotur&eacute;s non factur&eacute;</h1>
<form action="<%=pr.getLien()%>?but=pub/listePub_cnp.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=pub/fichePub.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<br/><br/>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
