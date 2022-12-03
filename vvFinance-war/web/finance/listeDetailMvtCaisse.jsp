<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

String lien= null;
UserEJB u = null;
  String nomPage = "finance/listeMvtCaisse.jsp";
  String apres="finance/visualiserMvtCaisse.jsp";
  int pazy=1;
  int nbPage=0;
  String tiers="";
  String rem="";
  String idMere="";
  String paruInf="";
  String paruSup="";
  
  Utilitaire utilitR=new Utilitaire();
  ResultatEtSomme dMvtCaisseRs =  null;
  DetailMvtCaisse [] detailMvtCaisse = null;
  double reportInit=0;
 %>
<%

  u=(UserEJB)session.getValue("u");
 lien=(String)session.getValue("lien");
 idMere=request.getParameter("idMere");
 tiers=request.getParameter("tiers");
   rem=request.getParameter("rem");
   idMere=request.getParameter("idMere");
   paruInf=request.getParameter("paruInf");
   paruSup=request.getParameter("paruSup");

%>
<%
  try{
 
	  paruInf=request.getParameter("paruInf");if ((paruInf==null)||paruInf.compareTo("")==0) paruInf="";
	  paruSup=request.getParameter("paruSup");if ((paruSup==null)||paruSup.compareTo("")==0) paruSup="%";
  
  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
  dMvtCaisseRs =u.findDetMvtCaisseParu(idMere,tiers, rem, idMere, paruInf, paruSup, pazy);
  detailMvtCaisse =(DetailMvtCaisse[])dMvtCaisseRs.getResultat();
  nbPage=Utilitaire.calculNbPage(dMvtCaisseRs.getSommeEtNombre()[2]);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Details Mouvements de caisse </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les mouvements de caisse)</p>
<form action="<%=lien%>?but=<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    
    <tr>

            <td class="left">id Mouvement</td>
            <td> <div align="center">
              <input name="idMere" type="text" class="champ" id="idMere" value="<%=idMere%>">
            </div></td>
            <td class="left">tiers</td>
            <td> <div align="center">
              <input name="tiers" type="text" class="champ" id="tiers" size="10" value="<%=tiers%>">
            </div></td>
          </tr>
          <tr>
            <td class="left">rem</td>
            <td ><div align="center">
              <input name="rem" type="text" class="champ" id="rem" size="10" value="<%=rem%>">
            
            </div></td>
            <td class="left"></td>
            <td></td>
          </tr>
           <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="paruInf" type="text" class="champ"   id="paruInf" value="<%=paruInf%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="paruSup" type="text" class="champ"   id="paruSup" value="<%=paruSup%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>
         
      </table></td>
    </tr>

        </table></td>
    </tr>

 
      <tr>
        <td height="30" align="center">
        
      
          
          
          </td>
      </tr>
      <tr>
        <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"> <input type="submit" name="Submit" value="Lister" class="submit">
              </td>
              <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
              </td>
            </tr>
        </table></td>
    </tr>
  </table>


</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Nb</td>
          <td width="146" align="right" valign="top"><div align="center">Somme Debit</div></td>
          <td width="160" align="right" valign="top"><div align="center"><strong>Somme Credit </strong></div></td>
          <td width="126" align="center" valign="top">Reste</td>
        </tr>

        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><%=dMvtCaisseRs.getSommeEtNombre()[2] %></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(dMvtCaisseRs.getSommeEtNombre()[0])%></div></td>
          <td align="right"><%=utilitR.formaterAr(dMvtCaisseRs.getSommeEtNombre()[1] )%></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(reportInit+dMvtCaisseRs.getSommeEtNombre()[1]-dMvtCaisseRs.getSommeEtNombre()[0])%></div></td></tr>
      </table>
      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">

          <td width="66" align="center" valign="top">Debit</td>
                   <td width="153" align="right" valign="top"><div align="center">Credit</div></td>
          <td width="153" align="right" valign="top"><div align="center">Tiers</div></td>
          <td width="102" align="center" valign="top">Remarque</td>
          <td width="102" align="center" valign="top">Parution</td>
<td width="102" align="center" valign="top"></td>
        </tr>
<%for (int i =0;i<detailMvtCaisse.length;i++){
%>
 <tr>

          <td width="66" align="center" valign="top"><%=detailMvtCaisse[i].getDebit()%></td>
                   <td width="153" align="right" valign="top"><div align="center"><%=detailMvtCaisse[i].getCredit()%></div></td>
          <td width="153" align="right" valign="top"><div align="center"><%=detailMvtCaisse[i].getTiers()%></div></td>
          <td width="102" align="center" valign="top"><%=detailMvtCaisse[i].getRemarque()%></td>
          <td width="102" align="center" valign="top"><%=detailMvtCaisse[i].getParution()%></td>
<td width="102" align="center" valign="top"></td>
        </tr>
<%
}
%>
      </table>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=dMvtCaisseRs.getSommeEtNombre()[2]%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=nbPage%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
         <a href="<%=lien%>?but=finance/listeDetailMvtCaisse.jsp&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&rem=<%=Utilitaire.remplacePourcentage(rem)%>&idMere=<%=Utilitaire.remplacePourcentage(idMere)%>&paruInf=<%=Utilitaire.remplacePourcentage(paruInf)%>&paruSup=<%=Utilitaire.remplacePourcentage(paruSup)%>&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
      <a href="<%=lien%>?but=finance/listeDetailMvtCaisse.jsp&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&rem=<%=Utilitaire.remplacePourcentage(rem)%>&idMere=<%=Utilitaire.remplacePourcentage(idMere)%>&paruInf=<%=Utilitaire.remplacePourcentage(paruInf)%>&paruSup=<%=Utilitaire.remplacePourcentage(paruSup)%>&pazy=<%=pazy%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>


</td>
</tr>
</table>
<br>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>