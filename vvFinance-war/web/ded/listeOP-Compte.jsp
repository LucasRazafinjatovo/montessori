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
Oppaye p = new Oppaye();
String etat="Oppayelccompte";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","remarque","designationLc","idTypeLigne","idDirection","idEntite","mois","annee","idFournisseur", "numCompte"};
String listeInt[]={"mois","daty","montant"};
String libEntete[]={"id","daty","ded_Id","idLigne","remarque","montant","paye"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOP-Compte.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
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

String colSomme[]={"montant","paye"};
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister les Ordres de paiement </h1>
<form action="<%=pr.getLien()%>?but=ded/listeOP-Compte.jsp" method="post" name="listeop" id="listeop">
<%
out.println(pr.getFormu().getHtmlEnsemble());
if(type.compareTo("anomalie")!=0){%>
etat : 	<select name="etat" class="champ" id="etat" >
            <option value="opPayelccompte">Tous</option>
            <option value="opPayelccompteAViser"  <%if(etat.compareTo("opPayelccompteAViser")==0) out.println("selected");%>>Non vise</option>
            <option value="opPayelccompte"  <%if(etat.compareTo("opPayelccompte")==0) out.println("selected");%>> Vise</option>
            <option value="oppayenonrapprochecompte"  <%if(etat.compareTo("oppayenonrapprochecompte")==0) out.println("selected");%>> Paye no rapproche</option>
		</select>
<%}%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp",pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=lc/visualiserDetailLC.jsp"};
String colonneLien[]={"id", "ded_Id", "idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=ded/apresVisualiserOrdonnerPayement.jsp" method="post" name="listeop" id="listeop">
	<input type="submit" name="Submit" value="OP Prevision" class="submit" onClick="acte.value='previsionmultiple'">&nbsp;
	<input name="acte" type="hidden" id="acte" value="viser">
	<%
	out.println(pr.getTableau().getHtmlWithCheckbox());
	%>
</form>
<%
out.println(pr.getBasPage());
%>


