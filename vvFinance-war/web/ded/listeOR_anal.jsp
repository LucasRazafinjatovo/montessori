<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="ded.*" %>
<%
Analyse_compta_oppayelc p=new Analyse_compta_oppayelc();
String etat="ANALYSE_COMPTA_ORPAYELC";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[] = {"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant"};
String listeInt[]={"mois","daty","montant"};

String colDefaut[]={"id","daty","ded_id","idLigne"};
String somDefaut[]={"montant","paye","parution"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,4,3);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOR_anal.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
Direction to2=new Direction();
to2.setNomTable("direction");
liste[0]=new Liste("iddirection",to2,"libelledir","libelledir");
liste[1]=new Liste("mois1");
((Liste)(liste[1])).makeListeMois();
liste[2]=new Liste("mois2");
((Liste)(liste[2])).makeListeMois();
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.creerObjetPage();


%>
<h1>Liste des OR Grouper</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOR_anal.jsp" method="post" name="listeOr" id="listeOr">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="ANALYSE_COMPTA_ORPAYELC">Tous</option>
              <option value="ANALYSE_COMPTA_ORPAYELCAVISER"  <%if(etat.compareTo("orPayelcAViser")==0) out.println("selected");%>>non vise</option>
            <option value="ANALYSE_COMPTA_ORPAYELC"  <%if(etat.compareTo("orPayelc")==0) out.println("selected");%>> vise</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOR.jsp",pr.getLien()+"?but=facture/visualiserFactureClient.jsp",pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"};
  //String colonneLien[]=pr.getColGroupe();
String colonneLien[]={"id","ded_id","idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
//String attLien[]={"idOP","idBC","numObjet"};
//pr.getTableau().setAttLien(attLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
