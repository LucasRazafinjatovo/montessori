<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="ded.OpLcCompletCompte" %>
<%
UserEJB u = null;
u = (user.UserEJB)session.getValue("u");
String type = "";
if(request.getParameter("type")!=null && request.getParameter("type").compareToIgnoreCase("")!=0)
  type=request.getParameter("type");
OpLcCompletCompte p=new OpLcCompletCompte();
String etat="ORVISENONPAYECOMPTE";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant","paye","idFournisseur","compte"};
String listeInt[]={"mois","daty","montant","paye"};
String libEntete[]={"id","daty","ded_id","idLigne","montant","remarque","paye","compte"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOR-compte.jsp");
affichage.Champ[] liste=new affichage.Champ[6];

TypeObjet to=new TypeObjet();
to.setNomTable("typeentree");
liste[0]=new Liste("idTypeLigne",to,"val","val");
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[1]=new Liste("identite",to1,"val","val", true);
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
<h1>Liste des OR</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOR-compte.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());
if(type.compareTo("anomalie")!=0){%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="ORPAYELCCOMPTE">Tous</option>
              <option value="ORPAYELCAVISERCOMPTE"  <%if(etat.compareTo("ORPAYELCAVISERCOMPTE")==0) out.println("selected");%>>non vise</option>
              <option value="ORPAYELCCOMPTE"  <%if(etat.compareTo("ORPAYELCCOMPTE")==0) out.println("selected");%>> vise</option>
              <option value="ORVISENONPAYECOMPTE"  <%if(etat.compareTo("ORVISENONPAYECOMPTE")==0) out.println("selected");%>> vise et non paye</option>
</select>
<%}%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOR.jsp",pr.getLien()+"?but=facture/visualiserFactureClient.jsp",pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"};
String colonneLien[]={"id","ded_id","idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String attLien[]={"idOP","idBC","numObjet"};
pr.getTableau().setAttLien(attLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
if(etat.compareToIgnoreCase("ORVISENONPAYECOMPTE")==0 && type.compareTo("anomalie")!=0){%>
<form action="<%=pr.getLien()%>?but=ded/paiementMultipleOr.jsp" method="post">
	<%
	out.println(pr.getTableau().getHtmlWithCheckbox());
	if(u.getUser().getLoginuser().compareToIgnoreCase("tahina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("tsima")==0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina")==0){
	%>
	<input type="hidden" name="typeObjet" value="ORDONNERPAYEMENT" class="submit">
	<input type="submit" name="Submit" value="Payer" class="submit">
	<input name="acte" type="hidden" id="acte" value="Payer">
	<%
	}%>
</form>
<%
} else{
	out.println(pr.getTableau().getHtml());
}
	out.println(pr.getBasPage());
%>
