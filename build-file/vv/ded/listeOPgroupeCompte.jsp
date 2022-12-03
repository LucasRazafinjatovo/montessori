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
String etat="opPayelccompte";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","designationLc","idTypeLigne","numCompte","idEntite","mois","iddirection","annee","idFournisseur"};
String listeInt[]={"mois","daty","montant"};

String colDefaut[]={"id","daty","ded_Id","idLigne"};
String somDefaut[]={"montant","paye"};

PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,4,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOPgroupeCompte.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
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

pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple();
//pr.preparerDataFormu();
%>
<h1>Lister les Ordres de paiement Groupe</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOPgroupeCompte.jsp" method="post" name="listeopg" id="listeopg">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat">
              <option value="opPayelccompte">Tous</option>
              <option value="opPayelccompteAViser"  <%if(etat.compareTo("opPayelccompteAViser")==0) out.println("selected");%>>non vise</option>
            <option value="opPayelccompte"  <%if(etat.compareTo("opPayelccompte")==0) out.println("selected");%>> vise</option>
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
