<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>

<%
Ecole ecole=new Ecole();
//ecole.setNomTable("ecole");
PageUpdate pi=new PageUpdate(ecole,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet typeEcole=new TypeObjet();
typeEcole.setNomTable("typeecole");
liste[0]=new Liste("typeEcole",typeEcole,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("nom").setType("texte");
pi.getFormu().getChamp("lieu").setType("texte");
pi.getFormu().getChamp("remarque").setType("textarea");
pi.preparerDataFormu();
%>

<h1>Modification d'une &eacute;cole</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="ecole" id="ecole">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="etudiant/listeEcole.jsp">
 <input name="classe" type="hidden" id="classe" value="etudiant.Ecole">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
