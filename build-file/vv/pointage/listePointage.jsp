<%@ page import="user.*" %>
<%@ page import="pointage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="pointage/listePointage.jsp";
        String lien= null;

        String heureInf = null;
         String heureSup = null;
        String datyinf = null;
         String datySup = null;
          String idPointage = null;
          String nom = null;
          String type = null;
        String agence = null;
        String machine = null;
        String ip = null;
        UserEJB u = null;
        pointage.Pointage[] fm=null;
        int pazy=0;
	int nbParPazy=Parametre.getNbParPage();

%>
<%
         pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
         heureInf = request.getParameter("heureInf");
         heureSup = request.getParameter("heureSup");
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         idPointage = request.getParameter("idPointage");
         nom = request.getParameter("nom");
         machine = request.getParameter("machine");
         ip = request.getParameter("ip");
         type = request.getParameter("type");
         agence = request.getParameter("agence");
         if ((heureInf == null)|| heureInf.compareTo("")==0) heureInf="";
         if (heureSup== null || heureSup.compareTo("")==0) heureSup="";
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (idPointage==null || idPointage.compareTo("")==0) idPointage="%";
          if (nom==null || nom.compareTo("")==0) nom="%";
         if ((machine==null)|| machine.compareTo("")==0) machine="%";
         if ((ip==null)|| ip.compareTo("")==0) ip="%";
         if ((type==null)|| type.compareTo("")==0) type="%";
         if ((agence==null)|| agence.compareTo("")==0) agence="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception, RemoteException;
fm = u.findPointage(idPointage,nom,datyinf,datySup,heureInf, heureSup,type,"%",ip,agence,machine);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des Pointages</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les Pointages)</p>
<form action="<%=lien%>?but=facture/listeEcriture.jsp" method="post" name="listePointage">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>



<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=datyinf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin :</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Heure début :</td>
            <td><input name="heureInf" type="text" class="champ" id="heureInf" value="<%=heureInf%>"></td>
            <td class="left">Heure fin :</td>
            <td><input name="heureSup" type="text" class="champ" id="heureSup" value="<%=heureSup%>"></td>
          </tr>
          <tr>
            <td class="left">Id Pointage :</td>
            <td><input name="idPointage" type="text" class="champ" id="idPointage" value="<%=idPointage%>"></td>
            <td class="left">Utilisateur :</td>
            <td><input name="nom" type="text" class="champ" id="nom" value="<%=nom%>"></td>
          </tr>
          <tr>
            <td class="left">Machine :</td>
            <td><input name="machine" type="text" class="champ" id="machine" value="<%=machine%>"></td>
            <td class="left">Ip :</td>
            <td><input name="ip" type="text" class="champ" id="ip" value="<%=ip%>"></td>
          </tr>
          <tr>
            <td class="left">Type Pointage :</td>
            <td><input name="idPointage" type="text" class="champ" id="idPointage" value="<%=idPointage%>"></td>
            <td class="left">Utilisateur :</td>
            <td><input name="nom" type="text" class="champ" id="nom" value="<%=nom%>"></td>
          </tr>
          <tr>
            <td class="left">Machine :</td>
            <td><input name="machine" type="text" class="champ" id="machine" value="<%=machine%>"></td>
            <td class="left">Ip :</td>
            <td><input name="ip" type="text" class="champ" id="ip" value="<%=ip%>"></td>
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
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr class="head">
          <td  height="25" align="center">Id</td>
          <td  height="106" align="center">user</td>
          <td width="78" align="center">Daty</td>
          <td width="80" align="center">Heure</td>
          <td align="center" width="122">Type</td>
          <td align="center" width="129">IP</td>
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
          <td  height="25" align="center" width="81"><a href="<%=lien%>?idPointage=<%=fm[i].getTuppleID()%>&but=pointage/detailPointage.jsp"><%=fm[i].getTuppleID()%></a></td>
          <td width="106" align="right">&nbsp;<%=fm[i].getIdUser()%>&nbsp;</td>
          <td width="78" align="right"> <div align="center"><%=Utilitaire.formatterDaty(fm[i].getDaty())%> </div></td>
          <td align="center" width="80"><a href="<%=lien%>?but=facture/detailCompte.jsp&idCompte=<%=fm[i].getHeure()%>"><%=fm[i].getHeure()%></a> </td>
          <td align="center" width="122"><div align="right"><%=fm[i].getIdType()%> </div></td>
          <td align="center" width="129"><div align="right"><%=fm[i].getIp()%></div></td>
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

         if ((heureInf == null)|| heureInf.compareTo("")==0) heureInf="";
         if (heureSup== null || heureSup.compareTo("")==0) heureSup="";
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (idPointage==null || idPointage.compareTo("")==0) idPointage="%";
          if (nom==null || nom.compareTo("")==0) nom="%";
         if ((machine==null)|| machine.compareTo("")==0) machine="%";
         if ((ip==null)|| ip.compareTo("")==0) ip="%";
         if ((type==null)|| type.compareTo("")==0) type="%";
         if ((agence==null)|| agence.compareTo("")==0) agence="%";

%>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat : </b><%=fm.length%></td><td align="right"><%if(fm.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%=fm.length/nbParPazy+1%><%}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
	<a href="<%=lien%>?but=facture/listeEcriture.jsp&datyinf=<%=datyinf%>&pazy=<%=pazy-1%>&datySup=<%=datySup%>&idPointage=<%=Utilitaire.remplacePourcentage(idPointage)%>&nom=<%=Utilitaire.remplacePourcentage(nom)%>&type=<%=Utilitaire.remplacePourcentage(type)%>&machine=<%=Utilitaire.remplacePourcentage(machine)%>&ip=<%=Utilitaire.remplacePourcentage(ip)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(fm.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/listeEcriture.jsp&datyinf=<%=datyinf%>&pazy=<%=pazy%>&datySup=<%=datySup%>&idPointage=<%=Utilitaire.remplacePourcentage(idPointage)%>&nom=<%=Utilitaire.remplacePourcentage(nom)%>&type=<%=Utilitaire.remplacePourcentage(type)%>&machine=<%=Utilitaire.remplacePourcentage(machine)%>&ip=<%=Utilitaire.remplacePourcentage(ip)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>">&lt;&lt;Page
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
