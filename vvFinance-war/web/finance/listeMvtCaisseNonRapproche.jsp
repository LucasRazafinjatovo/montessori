<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
MvtCaisseTous p;
%>
<%
try{
p=new MvtCaisseTous();
p.setNomTable("MVTNONRAPPROCHE_LIBELLE");
String listeCrt[]={"designation","idordre","debit","credit","iddevise","id","daty","idmode","idcaisse","agence","tiers","numpiece","typemvt"};
String listeInt[]={"daty","debit","credit"};
String libEntete[]={"id","daty","designation","agence","idCaisse","debit","credit"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeMvtCaisseNonRapproche.jsp");
affichage.Champ[] liste=new affichage.Champ[4];
TypeObjet to=new TypeObjet();
to.setNomTable("devise");
liste[0]=new Liste("iddevise",to,"val","val", true);
TypeObjet to1=new TypeObjet();
to1.setNomTable("modepaiement");
liste[1]=new Liste("idmode",to1,"val","val", true);
Caisse to2=new Caisse();
to2.setNomTable("caisse");
liste[2]=new Liste("idcaisse",to2,"desccaisse","desccaisse", true);
TypeObjet to3=new TypeObjet();
to3.setNomTable("typemvt");
liste[3]=new Liste("typemvt",to3,"val","val", true);

pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("idMvt",7);


String colSomme[]={"debit","credit"};
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister les Mouvements de caisse sans Ligne credit</h1>
<form action="<%=pr.getLien()%>?but=finance/listeMvtCaisseNonRapproche.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>



</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/rapprochrMvtCaisse.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>