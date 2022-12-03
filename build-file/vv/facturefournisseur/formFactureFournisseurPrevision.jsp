<%@ page import="user.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%
FactureFournisseurPrevisionLc pj=new FactureFournisseurPrevisionLc();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet act=new TypeObjet();
act.setNomTable("devise");
liste[0]=new Liste("iddevise",act,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("dateemission").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("remarque").setType("textarea");
pi.getFormu().getChamp("designation").setType("textarea");
pi.getFormu().getChamp("montantttc").setLibelle("Montant TTC (Ar) ");
pi.getFormu().getChamp("tva").setLibelle("Montant TVA (Ar) ");
pi.getFormu().getChamp("lc").setLibelle("Lc unique");
pi.getFormu().getChamp("idfournisseur").setPageAppel("ded/choix_tiers.jsp");
pi.getFormu().getChamp("lc").setPageAppel("lc/listeLC2Choix.jsp");
pi.preparerDataFormu();
%>

<h1>Saisir prevision Facture fournisseur</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="ffprevision" id="ffprevision">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="facturefournisseur/formFactureFournisseurPrevision.jsp">
 <input name="classe" type="hidden" id="classe" value="facturefournisseur.FactureFournisseurPrevisionLc">

</form>
