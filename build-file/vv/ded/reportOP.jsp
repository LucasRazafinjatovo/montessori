<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
Oppaye p=new Oppaye();
String etat="Opnonpayelc";
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","remarque","designationLc","idTypeLigne","numCompte","idDirection","idEntite","mois","annee","idFournisseur"};
String listeInt[]={"mois","daty","montant"};
String libEntete[]={"id","daty","ded_Id","idLigne","remarque","montant","paye"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/reportOP.jsp");
affichage.Champ[] liste=new affichage.Champ[6];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
Direction dir=new Direction();
dir.setNomTable("direction");
liste[2]=new Liste("idDirection",dir,"libelledir","libelledir", true);
TypeObjet to=new TypeObjet();
to.setNomTable("beneficiaire");
liste[3]=new Liste("idEntite",to,"val","val", true);
TypeObjet tot=new TypeObjet();
tot.setNomTable("typesortie");
liste[4]=new Liste("idTypeLigne",tot,"val","val", true);
TypeObjet to5=new TypeObjet();
to5.setNomTable("agence");
liste[5]=new Liste("numCompte",to5,"val","val", true);
pr.getFormu().changerEnChamp(liste);

String colSomme[]={"montant","paye"};
pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.setNpp(100);
pr.creerObjetPageMultiple(libEntete,colSomme);
Oppaye []listeP=(Oppaye [])pr.getRs().getResultat();
%>
<h1>REPORT OP</h1>
<form action="<%=pr.getLien()%>?but=ded/reportOP.jsp" method="post" name="listeop" id="listeop">
<%
out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
  String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp",pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp",pr.getLien()+"?but=lc/visualiserDetailLC.jsp"};
String colonneLien[]={"id","ded_Id","idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<br>
<form name="mep" action="<%=pr.getLien() %>?but=ded/apresVisualiserOrdonnerPayement.jsp" method="post">
<input type="hidden" name="acte" value="reporter">
<input type="hidden" name="nb" value="<%=listeP.length%>">
<input type="hidden" name="bute" value="ded/reportOP.jsp">
<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">
<input type="submit" value="valider">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=20% align=center valign=top>remarque</td>
<td width=10% align=center valign=top>ded_Id</td>
<td width=10% align=center valign=top>idLigne</td>
<td width=28% align=center valign=top>montant</td>
<td width=25% align=center valign=top>daty</td>
<td width=28% align=center valign=top>annuler</td>
</tr>
<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><a href="<%=pr.getLien()%>?but=ded/visualiserOP.jsp&id=<%=listeP[i].getId()%>"><%=listeP[i].getId() %></a></td>
<td align=center><%=listeP[i].getRemarque() %></td>
<td align=center><a href="<%=pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp&ded_id="+listeP[i].getDed_id()%>"><%=listeP[i].getDed_id()  %></a></td>
<td align=center><a href="<%=pr.getLien()+"?but=lc/visualiserDetailLC.jsp&idLigne="+listeP[i].getIdLigne()%>"><%=listeP[i].getIdLigne() %></a></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontant()) %></td>
<td align=center><input type="text" name="daty<%=i%>" value=<%=Utilitaire.datetostring(listeP[i].getDaty()) %> ></td>
<td align=center><a href="<%=pr.getLien()+"?but=ded/apresVisualiserOrdonnerPayement.jsp&acte=annulerOp&numObjet="+listeP[i].getId()%>">X</a></td>
</tr>
<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">
<%}%>
</table>
</form>
<%
//out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
