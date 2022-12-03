<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="finance.*" %>
<%
    String idcaisse=request.getParameter("idcaisse");
    String daty1=request.getParameter("daty1");
    String daty2=request.getParameter("daty2");
    //String idecole=request.getParameter("idecole");
    //if(idecole.equals("%")){idecole="ECO000001";}
    MvtCaisse mvtCaisse = new MvtCaisse();
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = { "idcaisse","daty","designation","debit", "credit"};

    PageRecherche pr = new PageRecherche(mvtCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    System.out.println("daty1 = "+daty1);
    System.out.println("daty2 = "+daty2);
    pr.setAWhere("and idcaisse='"+idcaisse+"' and daty>=to_date('"+daty1+"','yyyy-mm-dd') and daty<=to_date('"+daty2+"','yyyy-mm-dd')");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Mouvement de caisse du <%=daty1%> &acirc; <%=daty2%></h1>
<br>
<%
    String libEnteteAffiche[] = { "Num  caisse","Date","Designation","D&eacute;bit", "Cr&eacute;dit"};;
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
