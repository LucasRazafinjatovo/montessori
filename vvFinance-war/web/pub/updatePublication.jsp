<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Publication p=new Publication();
p.setNomTable("PUBLICATIONupdate");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to);
TypeObjet j=new TypeObjet();
j.setNomTable("jour");
liste[1]=new Liste("jour",j,"val","val");
Rubrique r=new Rubrique();
r.setNomTable("rubrique");
liste[2]=new Liste("rubrique",r,"libelle","libelle");
pc.getFormu().getChamp("id").setAutre("readonly='true'");
pc.getFormu().getChamp("datyparution").setAutre("readonly='true'");
pc.getFormu().getChamp("datyparution").setValeur(request.getParameter("datyparution"));
pc.getFormu().getChamp("daty").setAutre("readonly='true'");
pc.getFormu().getChamp("daty").setValeur(request.getParameter("daty"));
pc.getFormu().getChamp("nbexth").setAutre("readonly='true'");
pc.getFormu().getChamp("nbpage").setAutre("readonly='true'");
pc.getFormu().getChamp("journal").setAutre("readonly='true'");
pc.getFormu().getChamp("numparution").setAutre("readonly='true'");

//out.print(request.getParameter("id"));
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
//Publication[] pb=(Publication[])CGenUtil.rechercher
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modification d'une publication de journal</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp&datyparu=<%=request.getParameter("datyparution")%>" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="nature" value="updatePublication">
</form>
