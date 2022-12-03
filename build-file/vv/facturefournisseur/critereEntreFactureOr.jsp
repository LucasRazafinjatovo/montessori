<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="lc.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>


<%!
FactureFournisseurOp p;
bean.Champ []nomC;
%>
<%
p=new FactureFournisseurOp();
nomC=ListeColonneTable.getFromListe(p,null);
String etat="factureclientorgroupe";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"idFactureFournisseur", "iddirection","annee","identite","numcompte","designationlc","idFournisseur","designation","numFact","idtypeligne","idligne","opmontant","reste","montantTTC","daty","mois","datyecheance"};
String listeInt[]={"mois","daty","montantTTC","opMontant","reste","datyecheance"};
String libEntete[]={"idFactureFournisseur","daty","designation","idFournisseur","montantTTC","opMontant","reste"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("facturefournisseur/critereEntreFactureOr.jsp");
affichage.Champ[] liste=new affichage.Champ[4];

liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
((Liste)(liste[1])).setDefaultSelected("12");
Direction to=new Direction();
to.setNomTable("direction");
liste[2]=new Liste("iddirection",to,"libelledir","libelledir");
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[3]=new Liste("identite",to1,"val","val");
((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantTtc");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("Client",6);

pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
String colSomme[]={"montantTTC","opMontant","reste"};
pr.setNpp(100);
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();

%>
<h1>Lister les factures Clients et Or </h1>
<form action="<%=pr.getLien()%>?but=facturefournisseur/critereEntreFactureOr.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="factureclientorgroupe">Tous</option>
              <option value="fcorgroupepaye"  <%if(etat.compareTo("fcorgroupepaye")==0) out.println("selected");%>>paye</option>
              <option value="fcorgroupeImpaye"  <%if(etat.compareTo("fcorgroupeImpaye")==0) out.println("selected");%>>impaye</option>
              <option value="factureclientorvise"  <%if(etat.compareTo("factureclientorvise")==0) out.println("selected");%>>vis&eacute;</option>
              <option value="factureclientornonvise"  <%if(etat.compareTo("factureclientornonvise")==0) out.println("selected");%>>non vis&eacute;</option>
option>
</select>



</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=facture/visualiserFactureClient.jsp",pr.getLien()+"?but=ded/listeOR_o.jsp"};
  /*
  Lien[] lienTableau={new Lien("pr.getLien()+"?but=facture/visualiserFactureClient.jsp")};
  */
String colonneLien[]={"idFactureFournisseur","opMontant"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);

out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
