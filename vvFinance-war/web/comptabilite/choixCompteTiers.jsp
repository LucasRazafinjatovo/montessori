<%@ page import="user.UserEJB" %>
<%@ page import="comptabilite.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%


        String lien				= null;
        UserEJB		u 			= null;

      CompteTiers clt[] = null;

      CompteTiers cltCrt=null;
      String id=null, idsociete=null, nom=null, reftiers=null, telephone=null, adresse=null
			, stat=null, nif=null, rcs=null;
          String champReturn = null;
          int nbPage = 0;
          String pazyS = null;
      	int color=0;
              String maxpageS= "";
              int maxpage=0;
              int minpage=0;
              int maxpageT=0;
              int pazy = 0;

		String vue = request.getParameter("compte");
		String apresTT = "?compte="+vue;
%>
<%
//Prendre les critères de filtre
cltCrt=new CompteTiers();
cltCrt.setNomTable("comptetiers_libelle");
cltCrt.setCompte(vue);
id=Utilitaire.remplacerNull(request.getParameter("id"));
cltCrt.setId(id);
idsociete=Utilitaire.remplacerNull(request.getParameter("idsociete"));
cltCrt.setIdsociete(idsociete);
nom=Utilitaire.remplacerNull(request.getParameter("nom"));
cltCrt.setNom(nom);
reftiers=Utilitaire.remplacerNull(request.getParameter("reftiers"));
cltCrt.setReftiers(reftiers);
telephone=Utilitaire.remplacerNull(request.getParameter("telephone"));
cltCrt.setTelephone(telephone);
adresse=Utilitaire.remplacerNull(request.getParameter("adresse"));
cltCrt.setAdresse(adresse);
stat=Utilitaire.remplacerNull(request.getParameter("stat"));
cltCrt.setStat(stat);
nif=Utilitaire.remplacerNull(request.getParameter("nif"));
cltCrt.setNif(nif);
rcs=Utilitaire.remplacerNull(request.getParameter("rcs"));
cltCrt.setRcs(rcs);
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

  ResultatEtSomme rs=CGenUtil.rechercherPage(cltCrt,null,null,pazy,"",null);
  clt = (CompteTiers[])rs.getResultat();
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
    <td>Liste des Comptes tiers</td>
  </tr>
</table>

<br>

<TABLE align="center" class="tableContent">
  <TR>
    <TD>
      <!-- mission-->
<fieldset class="fieldset1"><legend>Filtrer</legend>

<form action="choixCompteTiers.jsp" method="post">
  <table  align="center"  class="monographe" width="100%">
<tr>
<input type="hidden" value="<%=vue%>"/>
<td align="left">Id </td>
<td  width="35%"  align="left"><input name="id" id="id"  type="text" value="<%=id%>" size="25" style="text-align:left;"></td>
<td  align="left">Soci&eacute;t&eacute;</td>
<td width="35%" align="left"><input name="idsociete" id="idsociete" type="text" value="<%=idsociete%>" size="25" style="text-align:left;" /></td>
</tr>
<tr>
<td  align="left">Ref. tiers</td>
<td width="35%" align="left"><input name="reftiers" id="reftiers" type="text" value="<%=reftiers%>" size="25" style="text-align:left;" /></td>
<td align="left">Nom </td>
<td  width="35%"  align="left"><input name="nom" id="nom" type="text" value="<%=nom%>" size="25" style="text-align:left;"></td>
</tr>
<tr>
<td  align="left">T&eacute;l&eacute;phone</td>
<td width="35%" align="left"><input name="telephone" id="telephone" type="text" value="<%=telephone%>" size="25" style="text-align:left;" /></td>
<td align="left">Adresse </td>
<td  width="35%"  align="left"><input name="adresse" id="adresse" type="text" value="<%=adresse%>" size="25" style="text-align:left;"></td>
</tr>
<tr>
<td  align="left">Num. Stat</td>
<td width="35%" align="left"><input name="stat" id="stat" type="text" value="<%=stat%>" size="25" style="text-align:left;" /></td>
<td align="left">NIF </td>
<td  width="35%"  align="left"><input name="nif" id="nif" type="text" value="<%=nif%>" size="25" style="text-align:left;"></td>
</tr>
<tr>
<td  align="left">R.C.S</td>
<td width="35%" align="left"><input name="rcs" id="rcs" type="text" value="<%=rcs%>" size="25" style="text-align:left;" /></td>
<td></td><td></td>
</tr>
</table>
<input type="hidden" name="champReturn" value="<%=champReturn%>">


 <table align="center">
                        <tr><td><input type="submit" value="Afficher" class="bouton1"></td></tr>
		</table>
</form>
</fieldset>

<fieldset class="fieldset1">
<form action="apreschoix.jsp" method="post"  name="frmchx">
<div style="overflow:scroll;width:750px;" >
<input type="hidden" name="champReturn" value="<%=champReturn%>">
                <table align="center" class="monographe" width="100%">
                    <tr>
                        <td>-</td>
                        <td>ID.</td>
                        <td>Soci&eacute;t&eacute; </td>
                        <td>Compte</td>
						<td>Ref. tiers</td>
						<td>Nom</td>
						<td>T&eacute;l&eacute;phone</td>
						<td>Adresse</td>
						<td>Num. stat</td>
						<td>NIF</td>
						<td>RCS</td>
					</tr>
					<%for(int i=0;i<clt.length;i++){ %>
					<tr>
						<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=clt[i].getId()+";"+clt[i].getNom()+";"+clt[i].getIdsociete()+";"+clt[i].getCompte()+";"+clt[i].getReftiers()+";"+clt[i].getTelephone()+";"+clt[i].getAdresse()+";"+clt[i].getStat()+";"+clt[i].getNif()+";"+clt[i].getRcs()%>" class="radio" /></td>
						<td><%=clt[i].getId()%> </td>
                        <td><%=clt[i].getIdsociete()%>  </td>
						<td><%=clt[i].getCompte()%></td>
						<td><%=clt[i].getReftiers()%></td>
						<td><%=clt[i].getNom()%></td>
						<td><%=clt[i].getTelephone()%></td>
						<td><%=clt[i].getAdresse()%></td>
						<td><%=clt[i].getStat()%></td>
						<td><%=clt[i].getNif()%></td>
						<td><%=clt[i].getRcs()%></td>
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
         <a href="choixCompteTiers.jsp<%=apresTT%>&id=<%=Utilitaire.remplacePourcentage(id)%>&idsociete=<%=Utilitaire.remplacePourcentage(idsociete)%>&reftiers=<%=Utilitaire.remplacePourcentage(reftiers)%>&nom=<%=Utilitaire.remplacePourcentage(nom)%>&telephone=<%=Utilitaire.remplacePourcentage(telephone)%>&adresse=<%=Utilitaire.remplacePourcentage(adresse)%>&stat=<%=Utilitaire.remplacePourcentage(stat)%>&nif=<%=Utilitaire.remplacePourcentage(nif)%>&rcs=<%=Utilitaire.remplacePourcentage(rcs)%>&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
         <a href="choixCompteTiers.jsp<%=apresTT%>&id=<%=Utilitaire.remplacePourcentage(id)%>&idsociete=<%=Utilitaire.remplacePourcentage(idsociete)%>&reftiers=<%=Utilitaire.remplacePourcentage(reftiers)%>&nom=<%=Utilitaire.remplacePourcentage(nom)%>&telephone=<%=Utilitaire.remplacePourcentage(telephone)%>&adresse=<%=Utilitaire.remplacePourcentage(adresse)%>&stat=<%=Utilitaire.remplacePourcentage(stat)%>&nif=<%=Utilitaire.remplacePourcentage(nif)%>&rcs=<%=Utilitaire.remplacePourcentage(rcs)%>&pazy=<%=pazy-1%>">&lt;&lt;Page
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