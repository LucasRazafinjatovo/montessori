<%-- 
    Document   : mouvement-etudiant
    Created on : 22 mai 2018, 17:04:56
    Author     : pro
--%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>

<%
MouvementEtudiant mouvementEtudiant=new MouvementEtudiant();
PageInsert pi=new PageInsert(mouvementEtudiant,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet type=new TypeObjet();
type.setNomTable("type");
liste[0]=new Liste("type",type,"desce","val");
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("daty").setLibelle("Date");
pi.getFormu().getChamp("etudiant").setLibelle("Etudiant");
pi.getFormu().getChamp("etudiant").setDefaut(request.getParameter("idetudiant"));
pi.getFormu().getChamp("motif").setLibelle("Motif");
pi.getFormu().getChamp("type").setLibelle("Type");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.preparerDataFormu();
%>

<h1>Saisir mouvement etudiant</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="etudiant" id="etudiant">


<%
//pi.getFormu().makeHtmlInsertTabIndex();
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="etudiant/mouvement-etudiant.jsp">
 <input name="classe" type="hidden" id="classe" value="etudiant.MouvementEtudiant">
</form>

