<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%@ page import="ventegazety.*" %>
<%
ClotureAff pj=new ClotureAff();
pj.setNomTable("clotureAff");
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

  //pi.getFormu().getChamp("objet").setPageAppel("listeInvenduChoix.jsp");
pi.getFormu().getChamp("objet").setLibelle("Num compte");
  pi.getFormu().getChamp("daty").setLibelle("date de cloture");
   pi.getFormu().getChamp("datySaisie").setLibelle("date de saisie");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
     pi.getFormu().getChamp("datySup").setDefaut(Utilitaire.dateDuJour());
   pi.getFormu().getChamp("datySaisie").setDefaut(Utilitaire.dateDuJour());
  pi.getFormu().getChamp("remarque").setType("textarea");
  pi.getFormu().getChamp("typeObjet").setDefaut("pub");
  pi.getFormu().getChamp("typeObjet").setAutre("readonly='readonly'");
  pi.getFormu().getChamp("datySup").setLibelle("Date sup&eacute;rieur");
  affichage.Champ[] liste=new affichage.Champ[1];
  TypeObjet agence=new TypeObjet();
  agence.setNomTable("agence");
  liste[0]=new Liste("objet",agence,"val","id");
  pi.getFormu().changerEnChamp(liste);
  pi.preparerDataFormu();
%>

<h1>Cloturer pub</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipub" id="saisipub">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>




 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="pub/cloturePub.jsp">
 <input name="classe" type="hidden" id="classe" value="finance.ClotureAff">

</form>
