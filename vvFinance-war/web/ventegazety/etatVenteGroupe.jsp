<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>
<%@ page import="lc.Direction" %>
<%!
Etatvente p;
%>
<%
p=new Etatvente();
String etat="etatVente";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"vendeur","matricule","journal","place","province","type","numParution","daty","titre","jour","heure","rubrique"};
String listeInt[]={"daty","numParution"};

String colDefaut[]={"daty","journal","numParution","titre","jour","heure","rubrique"};
String somDefaut[]={"nbrePrise","vente","totalcommission","montant","recette"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,3,colDefaut,somDefaut,7,5);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/etatVenteGroupe.jsp");
affichage.Champ[] liste=new affichage.Champ[4];
Vendeur ve=new Vendeur();
liste[0]=new Liste("vendeur",ve,"surnom","surnom");
TypeObjet j=new TypeObjet();
j.setNomTable("jour");
liste[1]=new Liste("jour",j,"val","val");

TypeObjet journal = new TypeObjet();
journal.setNomTable("journal");
liste[3]=new Liste("journal",journal,"val","val",true);

Rubrique r=new Rubrique();
r.setNomTable("rubrique");
liste[2]=new Liste("rubrique",r,"libelle","libelle");
pr.getFormu().changerEnChamp(liste);
pr.setNpp(100);
pr.creerObjetPageMultiple();
%>
<h1>Etat de vente journal groupe</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/etatVenteGroupe.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="etatVente">Tous</option>
              <option value="etatVentePaye"  <%if(etat.compareTo("fcorgroupepaye")==0) out.println("selected");%>>paye</option>
            <option value="etatVenteImpaye"  <%if(etat.compareTo("fcorgroupeImpaye")==0) out.println("selected");%>>impaye</option>
</select>



</form>
<%
  //String lienTableau[]={pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString() ,pr.getLien()+"?but=facturefournisseur/critereEntreFactureOr.jsp"+pr.getFormu().getListeCritereString()};
//String colonneLien[]=pr.getColGroupe();
//pr.getTableau().setLien(lienTableau);
//pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
