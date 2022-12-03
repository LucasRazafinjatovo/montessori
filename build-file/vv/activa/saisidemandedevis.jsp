<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
String max=UserEJBBean.getMaxIdMarge();
String max2=UserEJBBean.getMaxIdTirage();

//System.out.println(max);
DemandeDevis m=new DemandeDevis();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];
CodeRV c = new CodeRV();
c.setNomTable("coderv");
liste[0]=new Liste("idCodeRV",c,"val","idcoderv");
pi.getFormu().getChamp("idClient").setPageAppel("listeClientDemandeDevis.jsp");
pi.getFormu().getChamp("idArticle").setPageAppel("listeArticleChoix.jsp");
pi.getFormu().getChamp("dateDevis").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("idMarge").setDefaut(max);
pi.getFormu().getChamp("idTirage").setDefaut(max2);
pi.getFormu().getChamp("idMarge").setAutre("readonly='readonly'");
pi.getFormu().getChamp("idTirage").setAutre("readonly='readonly'");
pi.getFormu().getChamp("designation").setType("textarea");
pi.getFormu().getChamp("idGestion").setVisible(false);
/*pi.getFormu().getChamp("idMarge").setVisible(false);
pi.getFormu().getChamp("idTirage").setVisible(false);
pi.getFormu().getChamp("idGestion").setVisible(false); */
//DemandeDevis[] mm=(DemandeDevis[])CGenUtil.rechercher(m,null,null,"where id")
/*GestionPrix w=new GestionPrix();
w.setIdArticle(pi.getFormu().getChamp("idArticle").getValeur());
GestionPrix[] gg=(GestionPrix[])CGenUtil.rechercher(w,null,null,"and idGestion="+max3);
m.setIdGestion(gg[0].getIdGestion()); */
//System.out.println("idArticle par defaut="+w.getIdArticle()+"idARTICLE="+gg[0].getIdArticle()+"ito ary le max idGestion ------"+gg[0].getIdGestion());
//pi.getFormu().getChamp("idGestion").setDefaut(gg[0].getIdGestion());
//pi.getFormu().getChamp("idMarge").setVisible(false);
pi.getFormu().getChamp("statut").setDefaut(String.valueOf(0));
pi.getFormu().getChamp("statut").setAutre("readonly='readonly'");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>
<h1>Saisir Demande Devis </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="demandedevis" id="demandedevis">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisidemandedevis.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.DemandeDevis">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="iddev-rmq"> -->
</form>
