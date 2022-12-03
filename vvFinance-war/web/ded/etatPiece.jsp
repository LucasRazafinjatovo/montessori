<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
RetourPieceComplet p;
PageRecherche pr;
%>
<%
try{
p=new RetourPieceComplet();
String etat="RetourPieceComplet";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"designation","montant","ded_id","coursier","tel","poste","societe","datyop","beneffinale"};
String listeInt[]={"datyop"};
String libEntete[]={"id","ded_id","datyop","designation","coursier","beneffinale","societe","montant"};
pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/etatPiece.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to1=new TypeObjet();
to1.setNomTable("LIBELLESOCIETE");
liste[0]=new Liste("societe",to1,"desce","id");
BenefPiece ben=new BenefPiece();
ben.setNomTable("benefpiece");
liste[1]=new Liste("coursier",ben,"nom","nom");
pr.getFormu().changerEnChamp(liste);
String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister pi&egrave;ce</h1>
<form action="<%=pr.getLien()%>?but=ded/etatPiece.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
etat : <select name="etat" class="champ" id="etat" >
              <option value="RetourPieceComplet"  <%if(etat.compareTo("RetourPieceComplet")==0) out.println("selected");%>>piece retourne</option>
              <option value="Piecenonretourne"  <%if(etat.compareTo("Piecenonretourne")==0) out.println("selected");%>>piece non retourne</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>