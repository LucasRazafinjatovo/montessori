<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
try
{
Pucomplet p=new Pucomplet();
String etat="PubComplet";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","libClient","idCat","libAgence","designation","libJournal","idMont","couleur","numParution","pagemisyazy","formulaire","montantVal"};
String listeInt[]={"numParution","pagemisyazy","formulaire","montantVal"};
String libEntete[]={"id","libClient","idMont","numParution","datyParution","montantVal","libAgence"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePub.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("format",6);

//String libAffiche[]={"id","libClient","format","numParution","datyParution","montantVal","libAgence"};
String colSomme[]={"montantVal"};
pr.creerObjetPage(libEntete,colSomme);
//pr.getTableau().setLibelleAffiche(libAffiche);
%>
<h1>Liste des pubicites</h1>
<form action="<%=pr.getLien()%>?but=pub/listePub.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="PubComplet">Tous</option>
              <option value="pubcompletnonfacture"  <%if(etat.compareTo("pubcompletnonfacture")==0) out.println("selected");%>>a facture</option>
            <option value="pubcompletdejafacture"  <%if(etat.compareTo("pubcompletdejafacture")==0) out.println("selected");%>> facture</option>
<option value="pubcompletPaye"  <%if(etat.compareTo("pubcompletPaye")==0) out.println("selected");%>> paye</option>
<option value="pubcompletnonpaye"  <%if(etat.compareTo("pubcompletnonpaye")==0) out.println("selected");%>> impaye</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=pub/fichePub.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
