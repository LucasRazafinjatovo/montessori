<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%
NoteEtudiantAvant pj=new NoteEtudiantAvant();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet typenote=new TypeObjet();
typenote.setNomTable("TYPENOTEAVANT");
liste[0]=new Liste("typeNoteAvant",typenote,"val","id");
TypeObjet matiere=new TypeObjet();
matiere.setNomTable("MATIEREAVANT");
liste[1]=new Liste("matiereAvant",matiere,"val","id");
TypeObjet mention=new TypeObjet();
mention.setNomTable("mention");
liste[2]=new Liste("mention",mention,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("etudiant").setPageAppel("listeEtudiantChoix.jsp");

pi.getFormu().getChamp("valeur").setType("texte");
pi.preparerDataFormu();
%>

<h1>Saisir note ant&eacute;rieur de l'&eacute;tudiant</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="noteetudiantavant" id="noteetudiantavant">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="etudiant/formNoteEtudiantAvant.jsp">
 <input name="classe" type="hidden" id="classe" value="etudiant.NoteEtudiantAvant">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
