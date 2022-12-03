<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%!
Pucomplet p;
%>
<%
p=new Pucomplet();
String etat="PubCompletSansTrait";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","libClient","idCat","libAgence","designation","libJournal","idMont","couleur","numParution","pagemisyazy","formulaire"};
String listeInt[]={"numParution","pagemisyazy","formulaire"};

String colDefaut[]={"libClient","libAGence"};
String somDefaut[]={"montantVal"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,2,2);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePubGroupe.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantVal");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("format",6);
pr.creerObjetPage();

%>
<h1>Liste des pubicites groupe</h1>
<form action="<%=pr.getLien()%>?but=pub/listePubGroupe.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="PUBCOMPLETSansTrait">Tous</option>
              <option value="pubcompletSansTraitnonfacture"  <%if(etat.compareTo("pubcompletSansTraitnonfacture")==0) out.println("selected");%>>a facture</option>
            <option value="pubcompletSansTraitdejafacture"  <%if(etat.compareTo("pubcompletSansTraitdejafacture")==0) out.println("selected");%>> facture</option>
<option value="pubcompletSansTraitPaye"  <%if(etat.compareTo("pubcompletSansTraitPaye")==0) out.println("selected");%>> paye</option>
<option value="pubcompletSansTraitnonpaye"  <%if(etat.compareTo("pubcompletSansTraitnonpaye")==0) out.println("selected");%>> impaye</option>
</select>



</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=pub/listePub.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=pub/listePub.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]=pr.getColGroupe();
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
