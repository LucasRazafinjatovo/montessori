<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%
ClotureAff pj=new ClotureAff();
pj.setNomTable("clotureAff");
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
Caisse ve=new Caisse();
ve.setNomTable("caisse");
liste[0]=new Liste("objet",ve,"desCcaisse","idCaisse");
pi.getFormu().changerEnChamp(liste);

  pi.getFormu().getChamp("daty").setLibelle("date de cloture");
  pi.getFormu().getChamp("datySaisie").setLibelle("date de saisie");
 pi.getFormu().getChamp("datySaisie").setDefaut(Utilitaire.dateDuJour());
 pi.getFormu().getChamp("datySup").setLibelle("Date sup&eacute;rieur");
  pi.getFormu().getChamp("remarque").setType("textarea");
  pi.getFormu().getChamp("typeObjet").setDefaut("caisse");
  pi.getFormu().getChamp("typeObjet").setAutre("readonly='readonly'");
  pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
     pi.getFormu().getChamp("datySup").setDefaut(Utilitaire.dateDuJour());
pi.preparerDataFormu();
%>

<h1>Cloturer Caisse</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisiprise" id="saisiprise">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>




 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="finance/clotureCaisse.jsp">
 <input name="classe" type="hidden" id="classe" value="finance.ClotureAff">

</form>
