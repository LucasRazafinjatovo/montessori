<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
Oppaye p=new Oppaye();
String etat="Oppayelc";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","remarque","designationLc","idTypeLigne","numCompte","idDirection","idEntite","mois","annee","idFournisseur"};
String listeInt[]={"mois","daty","montant"};
String libEntete[]={"id","daty","ded_Id","idLigne","remarque","montant","paye"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOP.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
Direction dir=new Direction();
dir.setNomTable("direction");
liste[2]=new Liste("idDirection",dir,"libelledir","libelledir");
TypeObjet to=new TypeObjet();
to.setNomTable("beneficiaire");
liste[3]=new Liste("idEntite",to,"val","val");
TypeObjet tot=new TypeObjet();
tot.setNomTable("typesortie");
liste[4]=new Liste("idTypeLigne",tot,"val","val");
TypeObjet to5=new TypeObjet();
to5.setNomTable("agence");
liste[5]=new Liste("numCompte",to5,"val","val");
pr.getFormu().changerEnChamp(liste);

String colSomme[]={"montant","paye"};
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister les Ordres de paiement </h1>
<form action="<%=pr.getLien()%>?but=ded/listeOP.jsp" method="post" name="listeop" id="listeop">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="opPayelc">Tous</option>
              <option value="opPayelcAViser"  <%if(etat.compareTo("opPayelcAViser")==0) out.println("selected");%>>non vise</option>
            <option value="opPayelc"  <%if(etat.compareTo("opPayelc")==0) out.println("selected");%>> vise</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp",pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=lc/visualiserDetailLC.jsp"};
String colonneLien[]={"id","ded_Id","idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
