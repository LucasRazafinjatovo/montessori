<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
Actualite pj=new Actualite();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet act=new TypeObjet();
act.setNomTable("TYPEACTU");
liste[0]=new Liste("typeActu",act,"val","id");
Direction to2=new Direction();
to2.setNomTable("direction");
liste[1]=new Liste("direction",to2,"libelledir","iddir");
TypeObjet ent=new TypeObjet();
ent.setNomTable("beneficiaire");
liste[2]=new Liste("entite",ent,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("heure").setVisible(false);
pi.getFormu().getChamp("actualite").setType("textarea");
pi.getFormu().getChamp("daty").setLibelleAffiche("date actu");
pi.preparerDataFormu();
%>

<h1>Saisir actualite</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="actualite/saisiactu.jsp">
 <input name="classe" type="hidden" id="classe" value="actualite.Actualite">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
