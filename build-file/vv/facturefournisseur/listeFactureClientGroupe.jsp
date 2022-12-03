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

String etat="factureclientorgroupe";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"idFournisseur","designation","numFact","designationLc","idTypeLigne","identite","iddirection","annee","idLigne","numcompte","mois","daty", "datyecheance"};
String listeInt[]={"mois","daty", "datyecheance"};

String colDefaut[]={"idFournisseur","identite"};
String somDefaut[]={"montantttc","opmontant","reste"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,2,3);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facturefournisseur/listeFactureClientGroupe.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
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
((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantTtc");
pr.getFormu().getListeChamp()[9].setLibelleAffiche("resp");
//((Liste)(pr.getFormu().getChamp("mois2"))).setDefaultSelected("12");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("Client",0);
pr.creerObjetPageMultiple();
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
//pr.getFormu().getChamp("annee").setA
%>
<h1>Liste des factures clients groupe</h1>
<form action="<%=pr.getLien()%>?but=facturefournisseur/listeFactureClientGroupe.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="factureclientorgroupe">Tous</option>
              <option value="fcorgroupepaye"  <%if(etat.compareTo("fcorgroupepaye")==0) out.println("selected");%>>paye</option>
              <option value="fcorgroupeImpaye"  <%if(etat.compareTo("fcorgroupeImpaye")==0) out.println("selected");%>>impaye</option>
              <option value="fcorgroupevise"  <%if(etat.compareTo("fcorgroupevise")==0) out.println("selected");%>>vise</option>
              <option value="fcorgroupenonvise"  <%if(etat.compareTo("fcorgroupenonvise")==0) out.println("selected");%>>non vise</option>
       </select>



</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]=pr.getColGroupe();
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
