<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
String type = "";
if(request.getParameter("type")!=null && request.getParameter("type").compareToIgnoreCase("")!=0)
  type=request.getParameter("type");
Oppaye_tdp p = new Oppaye_tdp();
String etat="Oppayelc_tdp";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","remarque","designationLc","idTypeLigne","numCompte","idDirection","idEntite","mois","annee","idFournisseur","date_paiement","typee"};
String listeInt[]={"mois","daty","montant","date_paiement"};
String libEntete[]={"id","daty","ded_Id","idLigne","remarque","montant","paye","date_paiement","typee"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,9);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/OP-multiple.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
Direction dir=new Direction();
dir.setNomTable("direction");
liste[2]=new Liste("idDirection",dir,"libelledir","libelledir", true);
TypeObjet to=new TypeObjet();
to.setNomTable("beneficiaire");
liste[3]=new Liste("idEntite",to,"val","val", true);
TypeObjet tot=new TypeObjet();
tot.setNomTable("typesortie");
liste[4]=new Liste("idTypeLigne",tot,"val","val", true);
TypeObjet to5=new TypeObjet();
to5.setNomTable("agence");
liste[5]=new Liste("numCompte",to5,"val","val", true);
pr.getFormu().changerEnChamp(liste);

String colSomme[]={"montant","paye"};
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>MAJ OP DATE DE PAIEMENT </h1>
<form action="<%=pr.getLien()%>?but=ded/OP-multiple.jsp" method="post" name="listeop" id="listeop">
<%
out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp",pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=lc/visualiserDetailLC.jsp"};
String colonneLien[]={"id", "ded_Id", "idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br />
<br />
<b>Date de paiement: </b><input type="text" name="dateDePaiement" value="<%=Utilitaire.dateDuJour()%>"/>
<br />
<form action="<%=pr.getLien()%>?but=ded/apresVisualiserOrdonnerPayement.jsp" method="post" name="listeop" id="listeop">
	<input name="acte" type="hidden" id="acte" value="modifierdatep">
        <input name="bute" type="hidden" id="bute" value="ded/OP-multiple.jsp">
	<%
	out.println(pr.getTableau().getHtmlWithCheckbox());
	%>
  <br />
  <input class="submit" type="submit" value="Modifier"/>
</form>
