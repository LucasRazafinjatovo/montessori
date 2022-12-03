<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Entree e = null;
        String idEntree = null;
        facture.Client clt = null;
        TypeObjet te = null;
        TypeObjet mod = null;
        Caisse caiss = null;
        String typa=null;
        String numFact=null;
        String desi=null;
        String nomClient=null;
        Client clt1=null;
	String a=null;
%>
<%
a =request.getParameter("a");
if(a==null)a="";
idEntree = request.getParameter("idEntree");
typa= request.getParameter("typa");
if(typa==null) typa="x";
numFact= request.getParameter("numFact");
nomClient= request.getParameter("nomClient");
%>
<%
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
e = u.findEntree(idEntree, "","", "%", "%", "%", "%", "%", "%", "%")[0];
caiss = u.findCaisse(e.getIdCaisse(),"%","%","%")[0];
//clt = u.findClient(e.getClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
te = u.findTypeObjet("TypeEntree",e.getIdTypeEntree(),"%")[0];

mod = u.findTypeObjet("ModePaiement",e.getIdModePaiement(),"%")[0];

if (typa.compareTo("FACT")==0)
{
desi="Règlement de la facture N°"+e.getNumpiece();
nomClient=nomClient;
}
else{
desi=e.getDesignation();
nomClient=e.getClient();
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>RE&Ccedil;U</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
   <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
          <td width="179" height="97" class="left">Re&ccedil;u la somme
            de :</td>
          <td width="259"><%=utilitaire.ChiffreLettre.convertRealToString((double)e.getMontant())%> <%=e.findDevise().getDesce()%></td>
        </tr>
        <tr>
          <td height="43" class="left">Paiement en :</td>
          <td><%=mod.getVal()%>&nbsp;</td>
        </tr>
        <tr>
          <td width="179" height="98" class="left">De :</td>
          <td width="259"><%=nomClient%> (representé par <%=e.getRemarque()%>)</td>
        </tr>
        <tr>
          <td height="117" class="left">Pour :</td>
          <td><%=desi%></td>
        </tr>
      </table></td>
  </tr>

  </table>
  <br>
  <br>
<table width="450" border="0" cellpadding="0" cellspacing="0" align="center" class="monographe">
  <!--DWLayoutTable-->
  <tr>
    <td width="450" height="43" valign="middle"><div align="right">
        <p class="left">Date
          : <%=Utilitaire.formatterDaty(e.getDaty())%></p>
      </div></td>
  </tr>
</table>
<%
if(a.compareTo("yes")!=0){
%>
	    <div align="center"><br>
  <br>
   <a href='javascript:Popup("finance/recuEntree.jsp?idEntree=<%=e.getTuppleID()%>&numFact=<%=numFact%>&nomClient=<%=nomClient%>&a=yes&typa<%=typa%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a></div>
<%
}
%>
