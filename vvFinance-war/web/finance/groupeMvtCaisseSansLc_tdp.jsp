<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
MvtCaisse_tdp p=new MvtCaisse_tdp();
p.setNomTable("MVTCAISSELETTREVALIDE_TDP");
String listeCrt[]={"designation","idOrdre","debit","credit","idDevise","id","daty","idMode","idCaisse","agence","tiers","numpiece","typemvt", "date_paiement", "typee"};
String listeInt[]={"daty","debit","credit","date_paiement"};

String colDefaut[]={"id","daty","designation","agence","date_paiement","typee"};
String somDefaut[]={"debit","credit"};
PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,2,colDefaut,somDefaut,6,2);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/groupeMvtCaisseSansLc_tdp.jsp");
affichage.Champ[] liste=new affichage.Champ[4];
TypeObjet to=new TypeObjet();
to.setNomTable("devise");
liste[0]=new Liste("idDevise",to,"val","val", true);
TypeObjet to1=new TypeObjet();
to1.setNomTable("modepaiement");
liste[1]=new Liste("idMode",to1,"val","val", true);
Caisse to2=new Caisse();
to2.setNomTable("caisse");
liste[2]=new Liste("idCaisse",to2,"desccaisse","desccaisse", true);
TypeObjet to3=new TypeObjet();
to3.setNomTable("typemvt");
liste[3]=new Liste("typemvt",to3,"val","val", true);

pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("idMvt",7);
pr.creerObjetPageMultiple();
%>
<h1>Grouper les Mouvements de caisse sans Ligne credit</h1>
<form action="<%=pr.getLien()%>?but=finance/groupeMvtCaisseSansLc_tdp.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>



</form>
<%
/*String lienTableau[]={pr.getLien()+"?but=finance/visualiserMvtCaisse.jsp"+pr.getFormu().getListeCritereString()};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);*/
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>