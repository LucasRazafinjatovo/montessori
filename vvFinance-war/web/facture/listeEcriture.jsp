<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

	String apres="facture/listeFactureAnalyse.jsp";
	String lien= null;
	facture.Ecriture fm[] = null;
	String datyinf = null;
 	String datySup = null;
  	String idEcriture = null;
  	String compte = null;
	String piece = null;
	String libelle = null;
    UserEJB u = null;
	int pazy=0;
	int nbParPazy=Parametre.getNbParPage();
%>
<%
         datyinf = request.getParameter("datyinf");
         datySup = request.getParameter("datySup");
         idEcriture = request.getParameter("idEcriture");
         compte = request.getParameter("compte");
         piece = request.getParameter("piece");
         libelle = request.getParameter("libelle");
		 pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (idEcriture==null || idEcriture.compareTo("")==0) idEcriture="%";
	 	 if (compte==null || compte.compareTo("")==0) compte="%";
         if ((piece==null)|| piece.compareTo("")==0) piece="%";
         if ((libelle==null)|| libelle.compareTo("")==0) libelle="%";

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception {
fm = u.findEcriture(idEcriture,datyinf,datySup,libelle,compte,piece);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des &eacute;critures Comptables</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>
<form action="<%=lien%>?but=facture/listeEcriture.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyinf" type="text" class="champ" id="datyInf" value="<%=datyinf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin :</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Id Ecriture :</td>
            <td><input name="idEcriture" type="text" class="champ" id="idEcriture" value="<%=idEcriture%>"></td>
            <td class="left">Compte :</td>
            <td><input name="compte" type="text" class="champ" id="compte" value="<%=compte%>"></td>
          </tr>
          <tr>
            <td class="left">Num Piece :</td>
            <td><input name="piece" type="text" class="champ" id="piece" value="<%=piece%>"></td>
            <td class="left">Libelle :</td>
            <td><input name="libelle" type="text" class="champ" id="libelle" value="<%=libelle%>"></td>
          </tr>
        </table>



</td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center">
<input name="Annuler" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
        </table>
        <div align="center"></div></td>
  </tr>
</table>
</form>

<div align="center"><strong><u>LISTE</u></strong>
</div>
<br>
  <br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td width="96"  height="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Total 
      d&eacute;bit:</strong></td>
    <td width="192" align="right"><%=Utilitaire.formaterAr((double)AdminEcriture.getSommeMontantDebit(fm))%> Ar
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="102" align="right"><strong>Total cr&eacute;dit
        :</strong></td>
    <td width="206" align="right"><%=Utilitaire.formaterAr((double)AdminEcriture.getSommeMontantCredit(fm))%> Ar
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr class="head">
          <td  height="25" align="center">Id</td>
          <td width="78" align="center">Daty</td>
          <td width="80" align="center">Compte</td>
          <td align="center" width="122">Debit</td>
          <td align="center" width="129">Credit</td>
          <td align="center" width="106">Num Piece</td>
        </tr>
        <%
int pejy=0;
if(pazy==0){
	pejy=0;
        pazy=1;
}else{
	pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>fm.length){
  pazy2=fm.length;
}
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td  height="25" align="center" width="81"><a href="<%=lien%>?idEcriture=<%=fm[i].getTuppleID()%>&but=facture/detailEcriture.jsp"><%=fm[i].getTuppleID()%></a></td>
          <td width="78" align="right"> <div align="center"><%=Utilitaire.formatterDaty(fm[i].getDaty())%> </div></td>
          <td align="center" width="80"><a href="<%=lien%>?but=facture/detailCompte.jsp&idCompte=<%=fm[i].getCompte()%>"><%=fm[i].getCompte()%></a> </td>
          <td align="center" width="122"><div align="right"><%=Utilitaire.formaterAr((double)fm[i].getDebit())%> Ar</div></td>
          <td align="center" width="129"><div align="right"><%=Utilitaire.formaterAr((double)fm[i].getCredit())%> Ar</div></td>
          <td width="106" align="right"><font size="1">&nbsp;<%=fm[i].getPiece()%>&nbsp;</font></td>
        </tr>
        <%
  }
  %>

        <tr>
          <td  height="2" align="center"></td>
          <td width="78" align="right"></td>
          <td width="80" align="center"></td>
          <td align="center" width="122"></td>
          <td align="center" width="129"></td>
          <td align="center" width="106"></td>
        </tr>
      </table>


    </td>
</tr>
</table><br>
<%
if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
if (datySup== null || datySup.compareTo("")==0) datySup="";
if (idEcriture==null || idEcriture.compareTo("%")==0) idEcriture="";
if (compte==null || compte.compareTo("%")==0) compte="";
if ((piece==null)|| piece.compareTo("%")==0) piece="";
if ((libelle==null)|| libelle.compareTo("%")==0) libelle="";

%>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat : </b><%=fm.length%></td><td align="right"><%if(fm.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%=fm.length/nbParPazy+1%><%}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
	<a href="<%=lien%>?but=facture/listeEcriture.jsp&datyinf=<%=datyinf%>&pazy=<%=pazy-1%>&datySup=<%=datySup%>&idEcriture=<%=Utilitaire.remplacePourcentage(idEcriture)%>&compte=<%=Utilitaire.remplacePourcentage(compte)%>&piece=<%=Utilitaire.remplacePourcentage(piece)%>&libelle=<%=Utilitaire.remplacePourcentage(libelle)%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(fm.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/listeEcriture.jsp&datyinf=<%=datyinf%>&pazy=<%=pazy%>&datySup=<%=datySup%>&idEcriture=<%=Utilitaire.remplacePourcentage(idEcriture)%>&compte=<%=Utilitaire.remplacePourcentage(compte)%>&piece=<%=Utilitaire.remplacePourcentage(piece)%>&libelle=<%=Utilitaire.remplacePourcentage(libelle)%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

<br>
<script language="javascript">
var cal1 = new calendar1(document.forms['listeFact'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeFact'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
