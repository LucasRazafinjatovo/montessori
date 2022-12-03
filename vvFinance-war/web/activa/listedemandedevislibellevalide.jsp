<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevisLibelle e=new DemandeDevisLibelle();
e.setNomTable("demandedevisarticleprix2");
String etat="demandedevisarticleprix2";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
e.setNomTable(etat);
String listeCrt[]={"idDevis","nomclient","coderv","article","designation","nombreimpression","margeBenefice","remise","dateDevis"};
String listeInt[]=null;
String libEntete[]={"idDevis","nomclient","coderv","article","designation","nombreimpression","remise","dateDevis"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listedemandedevislibelle.jsp");
pr.getFormu().getChamp("article").setPageAppel("listeArticleLibelleChoix.jsp");
pr.getFormu().getChamp("nomclient").setPageAppel("listeClientDemandeDevisChoix.jsp");
//pr.preparerDataFormu();
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des demandes devis valide</h1>
<form action="<%=pr.getLien()%>?but=activa/listedemandedevislibellevalide.jsp" method="post" name="demandedevislibelle" id="demandedevislibelle">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
           <option value="demandedevisarticlenonviser"  <%if(etat.compareTo("demandedevisarticlenonviser")==0) out.println("selected");%>>commande devis non vise</option>
           <option value="demandedevisarticleviser"  <%if(etat.compareTo("demandedevisarticleviser")==0) out.println("selected");%>>commande devis vise</option>
           <option value="demandedevisarticle"<%if(etat.compareTo("demandedevisarticle")==0) out.println("selected");%>>Tous</option>
       </select>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichedemandedevisvalide.jsp"};
String colonneLien[]={"idDevis"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

