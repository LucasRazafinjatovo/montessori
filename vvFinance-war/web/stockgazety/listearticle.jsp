<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="stockgazety.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
  Article ar=new Article();
  String listeCrt[]={"famille","uniteQuantification","libelle","prixUnitaire","codage","prixVente","prixAchat","seuilStock","remise"};
  String listeInt[]={"prixVente","prixAchat"};
  String libEntete[]={"id","famille","libelle","prixUnitaire","prixVente","prixAchat","seuilStock","remise"};
  PageRecherche pr=new PageRecherche(ar,request,listeCrt,listeInt,2,libEntete,8);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("stockgazety/listearticle.jsp");
  affichage.Champ[] liste=new affichage.Champ[2];
  TypeObjet obj=new TypeObjet();
  obj.setNomTable("unite_quantification");
  liste[0]=new Liste("uniteQuantification",obj,"val");
  TypeObjet obj2=new TypeObjet();
  obj2.setNomTable("famille");
  liste[1]=new Liste("famille",obj2,"val");
  pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
  String colSomme[]={"prixVente","prixAchat"};
  pr.creerObjetPage(libEntete,colSomme);
  //pr.preparerDataFormu();%>
  <h1>Liste article</h1>
  <form action="<%=pr.getLien()%>?but=stockgazety/listearticle.jsp" method="post" name="recherchearticle" id="recherchearticle">
  <%
  out.println(pr.getFormu().getHtmlEnsemble());%>
  </form>
  <%
  String lienTableau[]={pr.getLien()+"?but=stockgazety/ficheArticle.jsp"};
  String colonneLien[]={"id"};
  pr.getTableau().setLien(lienTableau);
  pr.getTableau().setColonneLien(colonneLien);
  out.println(pr.getTableauRecap().getHtml());%>
  <br>
  <%
  out.println(pr.getTableau().getHtml());
  out.println(pr.getBasPage());
  %>
