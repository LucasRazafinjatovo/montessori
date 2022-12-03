<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
Oppaye_tdp p=new Oppaye_tdp();
String etat="Oppayelc_tdp";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","designationLc","idTypeLigne","numCompte","idEntite","mois","iddirection","annee","idFournisseur","date_paiement","typee"};
String listeInt[]={"mois","daty","montant","date_paiement"};

String colDefaut[]={"id","daty","ded_Id","idLigne","date_paiement","typee"};
String somDefaut[]={"montant","paye"};

PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,6,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOPgroupe_tdp.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
Direction dir=new Direction();
dir.setNomTable("direction");
liste[2]=new Liste("iddirection",dir,"libelledir","libelledir");
TypeObjet to=new TypeObjet();
to.setNomTable("beneficiaire");
liste[3]=new Liste("idEntite",to,"val","val", true);
TypeObjet tot=new TypeObjet();
tot.setNomTable("typeSortie");
liste[4]=new Liste("idTypeLigne",tot,"val","val");
TypeObjet to5=new TypeObjet();
to5.setNomTable("agence");
liste[5]=new Liste("numCompte",to5,"val","val");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple();
//pr.preparerDataFormu();
%>
<h1>Lister les Ordres de paiement Groupe</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOPgroupe_tdp.jsp" method="post" name="listeopg" id="listeopg">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="oppayelc_tdp">Tous</option>
              <option value="oppayelcAViser_tdp"  <%if(etat.compareTo("opPayelcAViser")==0) out.println("selected");%>>non vise</option>
            <option value="OPPAYELCVISER_TDP"  <%if(etat.compareTo("opPayelc")==0) out.println("selected");%>> vise</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
//String attLien[]={""};
//pr.getTableau().setAttLien(attLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=ded/apresVisualiserOrdonnerPayement.jsp" method="post" name="listeop" id="listeop">
    
<br />
<b>Date de paiement: </b><input type="text" name="dateDePaiement" value="<%=Utilitaire.dateDuJour()%>"/>
<br />
        <input name="acte" type="hidden" id="acte" value="modifierdatep">
        <input name="bute" type="hidden" id="bute" value="ded/OP-multiple.jsp">
<%
out.println(pr.getTableau().getHtmlWithCheckbox());
%>
<br />
  <input class="submit" type="submit" value="Modifier"/>
</form>
<%
out.println(pr.getBasPage());
%>
