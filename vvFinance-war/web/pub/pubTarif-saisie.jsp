<%@page import="pub.PubType"%>
<%@page import="pub.PubTarif"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
PubTarif pj=new PubTarif();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
PubType to2=new PubType();
liste[0]=new Liste("idtype",to2,"designation","id");
pi.getFormu().getChamp("idtype").setLibelle("Type");
pi.getFormu().getChamp("durees").setVisible(false);
pi.getFormu().getChamp("duree").setLibelle("Duree");
pi.getFormu().getChamp("ID_PLAGE_HORAIRE").setLibelle("Plage horaire");
pi.getFormu().getChamp("montant").setLibelle("montant");
pi.getFormu().getChamp("date_effective").setLibelle("Date effective");
pi.getFormu().getChamp("date_effective").setDefaut(Utilitaire.dateDuJour());

pi.getFormu().getChamp("ID_PLAGE_HORAIRE").setPageAppel("listePubPlageHoraire.jsp");

pi.getFormu().changerEnChamp(liste);
//pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
//pi.getFormu().getChamp("actualite").setType("textarea");
//pi.getFormu().getChamp("daty").setLibelleAffiche("date actu");
pi.preparerDataFormu();
%>

<h1>Saisir Pub Tarif</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="pub/pubTarif-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="pub.PubTarif">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
