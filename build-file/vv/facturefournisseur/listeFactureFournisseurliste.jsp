<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="lc.Direction" %>
<%!
FactureFournisseurOp p;
%>
<%
p=new FactureFournisseurOp();
String etat="facturefournisseuropgroupe";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"idFactureFournisseur", "idFournisseur","designation","numFact","designationLc","idTypeLigne","identite","iddirection","annee","idLigne","numcompte","mois","daty","datyecheance"};
String listeInt[]={"mois","daty","datyecheance"};
String tabAffDefaut[]={"idFactureFournisseur","idFournisseur","idEntite","designation","numFact","montantttc","opmontant","reste"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,tabAffDefaut,8);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facturefournisseur/listeFactureFournisseurliste.jsp");

affichage.Champ[] liste=new affichage.Champ[5];
TypeObjet to=new TypeObjet();
to.setNomTable("typeSortie");
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
((Liste)(liste[4])).setDefaultSelected("12");
((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantTtc");
pr.getFormu().getListeChamp()[9].setLibelleAffiche("resp");
pr.getFormu().changerEnChamp(liste);

pr.getFormu().setLibelleAffiche("Fournisseur",1);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
String colSomme[]={"montantttc","opmontant","reste"};
pr.creerObjetPageMultiple(tabAffDefaut,colSomme);
%>
<h1>Liste des factures fournisseurs</h1>
<form action="<%=pr.getLien()%>?but=facturefournisseur/listeFactureFournisseurliste.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="facturefournisseuropgroupe">Tous</option>
              <option value="ffopgroupepaye"  <%if(etat.compareTo("ffopgroupepaye")==0) out.println("selected");%>>paye</option>
              <option value="ffopgroupeImpaye"  <%if(etat.compareTo("ffopgroupeImpaye")==0) out.println("selected");%>>impaye</option>
              <option value="facturefopgroupevise"  <%if(etat.compareTo("facturefopgroupevise")==0) out.println("selected");%>>vise</option>
              <option value="facturefopgroupenonvise"  <%if(etat.compareTo("facturefopgroupenonvise")==0) out.println("selected");%>>non vise</option>
       </select>



</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=facturefournisseur/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=ded/listeOP.jsp"};
String colonneLien[]={"idFactureFournisseur","idFournisseur","opmontant"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String[] attLien={"idBC","idFournisseur","ded_id"};
String valeurLien[]={"idFactureFournisseur","idFournisseur","idFactureFournisseur"};
pr.getTableau().setValeurLien(valeurLien);
pr.getTableau().setAttLien(attLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
