<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="stockgazety.*" %>
<%!
public static String essai(String hoho)
{
  return "salut";
}
%>
<%
Mouvementstock mvt=new Mouvementstock();
PageInsert pi=new PageInsert(mvt,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet obj=new TypeObjet();
obj.setNomTable("magasin");
liste[0]=new Liste("magasin",obj,"val");
TypeObjet obj2=new TypeObjet();
obj2.setNomTable("typedemouvement");
liste[1]=new Liste("typeDeMouvement",obj2,"val");
Article art=new Article();
art.setNomTable("article");
liste[2]=new Liste("article",art,"libelle","libelle");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("dateMouvement").setValeur(request.getParameter("dateMouvement"));
  pi.getFormu().getChamp("dateMouvement").setDefaut(Utilitaire.dateDuJour());
try{
pi.preparerDataFormu();
}catch(Exception e){
  System.out.print(" voici l'erreur " + e.getMessage());
}
%>

<h1>Saisir mouvement stock</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisimvt" id="saisimvt">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="stockgazety/saisimvtstock.jsp">
 <input name="classe" type="hidden" id="classe" value="stockgazety.Mouvementstock">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
