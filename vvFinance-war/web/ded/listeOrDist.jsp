<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="ded.OpLcComplet" %>
<%
UserEJB u=null;
String rec=null;
String recette=null;
String[] idrecettes = request.getParameterValues("choix");
if(idrecettes!=null){
  rec=Utilitaire.stringToTab(idrecettes,"'",",");
  recette=Utilitaire.stringToTab(idrecettes,"",",");
}
else{
  rec=request.getParameter("rec");
  recette=request.getParameter("recette");
}
u = (user.UserEJB)session.getValue("u");
OpLcComplet p=new OpLcComplet();
String etat="ORVISENONPAYELC_DIST";
p.setNomTable(etat);
String listeCrt[]={"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant","paye","idFournisseur"};
String listeInt[]={"mois","daty","montant","paye"};
String libEntete[]={"id","daty","ded_id","idLigne","montant","remarque","paye"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOrDist.jsp");
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

<h1>Liste des OR distribution</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOrDist.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<input type="hidden" name="rec" value="<%=rec%>"/>
<input type="hidden" name="recette" value="<%=recette%>"/>
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
<form action="<%=pr.getLien()%>?but=ded/ordonnerRecetteDist.jsp" method="post">
<%
  out.println(pr.getTableau().getHtmlWithRadio());
  session.removeAttribute("id");
  session.removeAttribute("idt");
  session.setAttribute("id",rec);
  session.setAttribute("idt",recette);

%>
   <input type="hidden" name="type" value="recette" class="submit">
   <input type="submit" name="Submit" value="Valider" class="submit">
</form>
<% out.println(pr.getBasPage());
%>
