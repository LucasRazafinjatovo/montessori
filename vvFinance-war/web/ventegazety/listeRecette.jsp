<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
RecetteLibelleType rv=new RecetteLibelleType();
String etat="RecetteLibelleType";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
rv.setNomTable(etat);
String listeCrt[]={"id","nom","place","province","numParution","daty","montant","journal","type"};
String listeInt[]={"daty","numParution","montant"};
String libEntete[]={"id","daty","nom","journal","numParution","daty","montant","type"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeRecette.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"montant"};

pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Liste des recettes</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeRecette.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="RecetteLibelleType">Tous</option>
              <option value="RecetteLibellenonfacture"  <%if(etat.compareTo("RecetteLibellenonfacture")==0) out.println("selected");%>>a facture</option>
            <option value="RecetteLibellefacture"  <%if(etat.compareTo("RecetteLibellefacture")==0) out.println("selected");%>> facture</option>
<option value="RecetteLibellePaye"  <%if(etat.compareTo("RecetteLibellePaye")==0) out.println("selected");%>> paye</option>
<option value="RecetteLibellenonpaye"  <%if(etat.compareTo("RecetteLibellenonpaye")==0) out.println("selected");%>> impaye</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheRecette.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

