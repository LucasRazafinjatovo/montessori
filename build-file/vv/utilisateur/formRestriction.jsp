
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="restriction.*" %>
<%@ page import="historique.*" %>
<%
Restriction rest=new Restriction();

PageInsert pi=new PageInsert(rest,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[2];

MapRoles rl=new MapRoles();
rl.setNomTable("roles");
liste[0]=new Liste("profil",rl,"idRole","idRole");
TypeObjet action=new TypeObjet();
action.setNomTable("action");
liste[1]=new Liste("action",action,"val","id");
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("tableRestrict").setPageAppel("listeTableChoix.jsp");

pi.preparerDataFormu();

%>

<h1>Saisie restriction</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="restriction" id="restriction">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="utilisateur/formRestriction.jsp">
 <input name="classe" type="hidden" id="classe" value="restriction.Restriction">
</form>
