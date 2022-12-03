<%@ page import="user.UserEJB" %>
<%@ page import="facture.Client" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%

        String apres="engagement/engagement.jsp";
        String lien				= null;
        UserEJB		u 			= null;

//variable tableau d'objet retourné par la méthode find
      facture.Client clt[] = null;
      facture.Client cltCrt=null;
          String idClient = null;
          String  nomClient = null;
          String adr = null;
          String numStat = null;
          String nif = null;
          String rc = null;
          String champReturn = null;
          int nbPage = 0;
          String pazyS = null;
              int color=0;
              String maxpageS= "";
              int maxpage=0;
              int minpage=0;
              int maxpageT=0;
              int pazy = 0;
%>
<%
//Prendre les critères de filtre
cltCrt=new Client();
idClient=Utilitaire.remplacerNull(request.getParameter("idClient"));
cltCrt.setIdClient(idClient);
nomClient=Utilitaire.remplacerNull(request.getParameter("nomClient"));
cltCrt.setNom(nomClient);
adr=Utilitaire.remplacerNull(request.getParameter("adr"));
cltCrt.setAdresse(adr);
numStat=Utilitaire.remplacerNull(request.getParameter("numStat"));
cltCrt.setNumstat(numStat);
nif=Utilitaire.remplacerNull(request.getParameter("nif"));
cltCrt.setNif(nif);
rc=Utilitaire.remplacerNull(request.getParameter("rc"));
cltCrt.setRc(rc);
champReturn = request.getParameter("champReturn");

pazyS =request.getParameter("pazy");
if ((pazyS==null)||(pazyS.compareTo("")==0)){pazy=1;}
else {
  pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
maxpageS=request.getParameter("maxpageS");

if ((maxpageS==null)||(maxpageS.compareTo("")==0)){maxpage=15;}
else {
 maxpage= Utilitaire.stringToInt(request.getParameter("maxpageS"));
}
minpage = maxpage-14;
 if (( champReturn== null)||champReturn.compareTo("")==0)champReturn="fournisseur";
                       if (request.getParameter("pazy")==null)
                       {
                         pazy=1;
                       }
                       else
                       {
                         pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
%>
<%

  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");

  //Utiliser la méthode find :  findAgenceExecution(String id,String exercice,String libelle,String date1,String date2, String apresW, int page); ->retourne une classe retournant un objet gérant un objet Resultatetsomme
 //ResultatEtSomme rs=u.findClientPage(idClient, nomClient, "%","%","%", adr,numStat, nif,rc,"%","%",pazy);
  ResultatEtSomme rs=CGenUtil.rechercherPage(cltCrt,null,null,pazy,"",null);
  clt = (Client[])rs.getResultat();
  nbPage=Utilitaire.calculNbPage(rs.getSommeEtNombre()[0]);

 // if(maxpage>nbPage){maxpageT=nbPage;}else{maxpageT=maxpage;}
%>


<script language="JavaScript">
<!--
function page(page_dest){
        document.location=page_dest;
}
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
function Update(){
        window.opener.document.all.eng_titulaire.value = "G456546546";
        window.close();

}
//-->
</script>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body bgcolor="#ffffff">


<div id="header">

</div>
<!--fin table entete-->
<div id ="titre">

</div>
<!--table pour la page-->
<div id ="content">

<table  border="0" align="center"class="tableTitre">
  <tr>
    <td><!-- Liste engagements liquidés-->
        Liste des Tiers
        </td>
  </tr>
</table>

<br>

<TABLE align="center" class="tableContent">
  <TR>
    <TD>
      <!-- mission-->
<fieldset class="fieldset1"><legend>Filtrer</legend>

<form action="listeClientChoixPopUp.jsp" method="post">
  <table  align="center"  class="monographe" width="100%">
<tr>
<td align="left">id Client </td>
<td  width="35%"  align="left"><input name="idClient" id="idClient"  type="text" value="<%=idClient%>" size="25" style="text-align:left;"></td>
<td  align="left">Nom Client</td>
<td width="35%" align="left"><input name="nomClient" id="nomClient" type="text" value="<%=nomClient%>" size="25" style="text-align:left;" /></td>
</tr>
<tr>
<td align="left">Adresse </td>
<td  width="35%"  align="left"><input name="adr" id="adr" type="text" value="<%=adr%>" size="25" style="text-align:left;"></td>
<td  align="left">Num Stat</td>
<td width="35%" align="left"><input name="numStat" id="numStat" type="text" value="<%=numStat%>" size="25" style="text-align:left;"></td>
</tr>
<tr>
<td align="left">Nif </td>
<td  width="35%"  align="left"><input name="nif" id="nif" type="text" value="<%=nif%>" size="25" style="text-align:left;"></td>
<td  align="left">Registre C.</td>
<td width="35%" align="left"><input name="rc" id="rc" type="text" value="<%=rc%>" size="25" style="text-align:left;"></td>
</tr>
</table>
<input type="hidden" name="champReturn" value="<%=champReturn%>">


 <table align="center">
                        <tr><td><input type="submit" value="Afficher" class="bouton1"></td></tr>
                </table>
</form>
</fieldset>

<fieldset class="fieldset1">
<form action="../ded/apreschoixTiers.jsp" method="post"  name="frmchx">
<div style="overflow:scroll;width:750px;" >
<input type="hidden" name="champReturn" value="<%=champReturn%>">
                <table align="center" class="monographe" width="100%">
                        <tr>
                         <td>-</td>
                             <td>id Client.</td>
                             <td>Nom client </td>
                                                        <td>Adresse</td>
 <td>Stat</td>
  <td>NIF</td>
   <td>RC</td>

                  </tr>
    <%
        for(int i=0;i<clt.length;i++){
                // lcd = u.findLC(lcamenag[i].getIdLigne(),"%","%","%","%","%","%","%","%", "%","%","%","%","%","%")[0];


  %>
          <tr>
             <td><input type="radio" name="idClient" onMouseDown="getChoix()" value="<%=clt[i].getIdClient()%>" class="radio" /></td>
                        <td><%=clt[i].getIdClient()%> </td>
                             <td><%=clt[i].getNom()%>  </td>
                                                        <td><%=clt[i].getAdresse()%></td>
 <td><%=clt[i].getNumstat()%></td>
  <td><%=clt[i].getNif()%></td>
   <td><%=clt[i].getRc()%></td>

          </tr>
<%

}
%>
        </table>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=rs.getSommeEtNombre()[0]%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=nbPage%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
         <a href="choix_tiers.jsp?idClient=<%=Utilitaire.remplacePourcentage(idClient)%>&nomClient=<%=Utilitaire.remplacePourcentage(nomClient)%>&adr=<%=Utilitaire.remplacePourcentage(adr)%>&numStat=<%=Utilitaire.remplacePourcentage(numStat)%>&nif=<%=Utilitaire.remplacePourcentage(nif)%>&rc=<%=Utilitaire.remplacePourcentage(rc)%>&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
      <a href="choix_tiers.jsp?idClient=<%=Utilitaire.remplacePourcentage(idClient)%>&nomClient=<%=Utilitaire.remplacePourcentage(nomClient)%>&adr=<%=Utilitaire.remplacePourcentage(adr)%>&numStat=<%=Utilitaire.remplacePourcentage(numStat)%>&nif=<%=Utilitaire.remplacePourcentage(nif)%>&rc=<%=Utilitaire.remplacePourcentage(rc)%>&pazy=<%=pazy%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

        <!-- Table permettant d'afficher la liste des pages -->

</div>


<!-- FIN TABLE page-->





<input type="hidden" name="acte" value ="choix">
<input type="hidden" name="champReturn" value =<%=champReturn%>>
</form>
</fieldset>



    </TD></TR>
</TABLE>
</div>