<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>
<%@ page import="facture.*" %>

<%
  Client e=new Client();

String listeCrt[]={"nom","nif"};
String listeInt[]=null;
String libEntete[]={"nom","nif"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listeproductionlibelle.jsp");

//affichage.Champ[] liste=new affichage.Champ[3];
/*TypeObjet pay=new TypeObjet();
pay.setNomTable("pays");
liste[0]=new Liste("pays",pay,"val","id");
TypeObjet ville=new TypeObjet();
ville.setNomTable("ville");
liste[1]=new Liste("ville",ville,"val","id");

pr.getFormu().changerEnChamp(liste); */
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
Client[]listeP=(Client [])pr.getRs().getResultat();//liste
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des articles</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeClientChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listecommandechoix" id="listecommandechoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=facture/ficheclient.jsp"};
String colonneLien[]={"idClient"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
/*
 public String nom;
    public String nif;  public String adresse;   public String telephone;
    public String fax;  public String rc;  public String tp;
    public String quittance;  public String idRegime;  public String idClient;
    public String numstat;
*/
%>
<br>
<form action="<%=pr.getLien() %>?but=apresChoixClientProduction.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=14% align=center valign=top>id client</td>
<td width=9% align="center" valign="top">nomclient</td>
<td width=10% align=center valign=top>nif</td>
<td width=10% align=center valign=top>adresse</td>
<td width=10% align=center valign=top>tel</td>
<td width=14% align=center valign=top>fax</td>
<td width=14% align=center valign=top>rc</td>
<td width=14% align=center valign=top>tp</td>


</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getNom()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdClient() %></td>
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getNif() %></td>
<td align=center><%=listeP[i].getAdresse() %></td>
<td align=center><%=listeP[i].getTelephone() %></td>
<td align=center><%=listeP[i].getFax() %></td>
<td align=center><%=listeP[i].getRc() %></td>
<td align=center><%=listeP[i].getTp()%></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPage());
%>