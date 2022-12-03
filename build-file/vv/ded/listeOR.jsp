<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="ded.OpLcComplet" %>
<%
OpLcComplet p=new OpLcComplet();
String etat="orPayelc";
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
pr.setApres("ded/listeOR.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
TypeObjet to=new TypeObjet();
to.setNomTable("typeentree");
liste[0]=new Liste("idTypeLigne",to,"val","val");
TypeObjet to1=new TypeObjet();
to1.setNomTable("beneficiaire");
liste[1]=new Liste("identite",to1,"val","val", true);
Direction to2=new Direction();
to2.setNomTable("direction");
liste[2]=new Liste("iddirection",to2,"libelledir","libelledir");
liste[3]=new Liste("mois1");
((Liste)(liste[3])).makeListeMois();
liste[4]=new Liste("mois2");
((Liste)(liste[4])).makeListeMois();
TypeObjet to5=new TypeObjet();
to5.setNomTable("agence");
liste[5]=new Liste("numCompte",to5,"val","val");
//((Liste)(pr.getFormu().getChamp("colonne"))).setDefaultSelected("montantTtc");
//pr.getFormu().getListeChamp()[13].setLibelleAffiche("resp");
pr.getFormu().setLibelleAffiche("Agence",8);
//String libEntete[]={"id","daty","ded_id","idLigne","montant","remarque","paye"};
//String colSomme[]={"montant","paye","parution"};
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.creerObjetPageMultiple();


%>
<h1>Liste des OR Grouper</h1>
<form action="<%=pr.getLien()%>?but=ded/listeOR.jsp" method="post" name="listeOr" id="listeOr">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="orPayelc">Tous</option>
              <option value="orPayelcAViser"  <%if(etat.compareTo("orPayelcAViser")==0) out.println("selected");%>>non vise</option>
            <option value="orPayelc"  <%if(etat.compareTo("orPayelc")==0) out.println("selected");%>> vise</option>
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
