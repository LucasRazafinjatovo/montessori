<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
String type = "";
if(request.getParameter("type")!=null && request.getParameter("type").compareToIgnoreCase("")!=0)
  type=request.getParameter("type");
Livraisonmultiple_abonne p = new Livraisonmultiple_abonne();
String listeCrt[]={"id","nomvendeur","prenomvendeur","adresse_abonne","cin_abonne","telephone_abonne","quartier","secteur","datedebut_abonnement","datefin_abonnement"};
String listeInt[]={"datedebut_abonnement","datefin_abonnement"};
String libEntete[]={"id","nomvendeur","prenomvendeur","adresse_abonne","cin_abonne","telephone_abonne","quartier","secteur","datedebut_abonnement","datefin_abonnement"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,libEntete,10);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/livraisonmultiple-abonne.jsp");
String colSomme[]=null;
pr.getFormu().getChamp("nomvendeur").setLibelle("Nom Vendeur");
pr.getFormu().getChamp("prenomvendeur").setLibelle("Prenom Vendeur");
pr.getFormu().getChamp("adresse_abonne").setLibelle("Adresse");
pr.getFormu().getChamp("cin_abonne").setLibelle("CIN");
pr.getFormu().getChamp("telephone_abonne").setLibelle("Telephone");
pr.getFormu().getChamp("datedebut_abonnement1").setLibelle("Date debut abonnement 1");
pr.getFormu().getChamp("datedebut_abonnement2").setLibelle("Date debut abonnement 2");
pr.getFormu().getChamp("datefin_abonnement1").setLibelle("Date fin abonnement 1");
pr.getFormu().getChamp("datefin_abonnement2").setLibelle("Date fin abonnement 2");
pr.setNpp(100);
pr.setAWhere(" AND DATEFIN_ABONNEMENT >='"+Utilitaire.dateDuJour()+"'");
pr.creerObjetPageMultiple(libEntete,colSomme);
BenefPiece[] listeCoursier = (BenefPiece[])CGenUtil.rechercher(new BenefPiece(), null, null, " AND POSTE = 'coursier'");
//pr.preparerDataFormu();
%>
<h1>LIVRAISON MULTIPLE</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/livraisonmultiple-abonne.jsp" method="post" name="livraison" id="livraison">
<%
out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/abonne-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br />
<form action="<%=pr.getLien()%>?but=ventegazety/apresTypeVente.jsp" method="post" name="listeop" id="listeop">
<br />
<b>Coursier: </b><select name=coursier>
                     <%for(int i = 0; i<listeCoursier.length ; i++){%>
                     <option value="<%=listeCoursier[i].getId()%>"><%=listeCoursier[i].getNom()%></option>
                     <%}%>
                 </select>
<br />
	<input name="acte" type="hidden" id="acte" value="livraisonMultiple">
        <input name="bute" type="hidden" id="bute" value="ventegazety/livraisonmultiple-abonne.jsp">
	<%
        String libEnteteAffiche[] = {"id","Nom Vendeur","Prenom Vendeur","Adresse abonn&eacute;","CIN","Telephone","Quartier","Secteur","Date debut abo","Date fin abo"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtmlWithCheckbox());
	%>
<br />
<input class="submit" type="submit" value="Valider"/>
</form>
