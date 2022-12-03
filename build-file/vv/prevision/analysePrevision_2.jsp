<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<%!
        String lien= null;
        UserEJB u = null;
        String daty1 , daty2;
        String nomCol[]=null;
        String colonne = null;
        String ordre = null;
        int pazy=0;
        int npp=370;
        int nbParPazy=npp;
        int indiceDebut=0;
        int indiceFin=Parametre.getNbParPage();
        int nbPage=0;
        String suivant = null;
        PageRecherche pr = null;
        AnalysePrevision[] la=null;
        double lesMontants[] = null;
        AdminAnalysePrevision aap;
        double soldeInitial = 0;

%>
<%
daty1 = request.getParameter("daty1"); if(daty1 == null) daty1 = Utilitaire.dateDuJour();
daty2 = request.getParameter("daty2"); if(daty2 == null) daty2 = Utilitaire.dateDuJour();
nomCol=Utilitaire.getNomColonne(new AnalysePrevision());
ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="ASC";
colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="daty";
suivant = "daty1="+daty1+"&daty2="+daty2+"";
suivant = suivant+"&ordre="+Utilitaire.remplacePourcentage(request.getParameter("ordre"))+"&colonne="+Utilitaire.remplacePourcentage(request.getParameter("colonne"));
aap = new AdminAnalysePrevision();
String soldeInit = request.getParameter("soldeInitial"); if(soldeInit == null) soldeInit="0";
if (request.getParameter("pazy")==null){
    pazy=1;
}else{
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
}
%>
<%
try{
  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  la = u.findAnalysePrevision(daty1,daty2,colonne,ordre,"ANALYSEPREV_sans_typecharge");
  soldeInitial = Utilitaire.stringToDouble(soldeInit);
  aap.calculerSolde(la,soldeInitial);
  lesMontants = AnalysePrevision.getAllSommeMontant(la);
  if(la!=null){
    indiceDebut=Utilitaire.getBornePage(pazy,la,npp)[0];
    indiceFin=Utilitaire.getBornePage(pazy,la,npp)[1];
    nbPage=Utilitaire.calculNbPage(la.length,npp);
  }
}
catch(Exception e){
	e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("../erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>ANALYSE PREVISION SANS TYPECHARGE</h1>
<!-- RECHERCHE -->
<form action="analysePrevision_2.jsp" method="post" name="analysePrevision" id="analysePrevision">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
           <tr>
            <td class="left">daty1 :</td>
            <td> <input name="daty1" type="text" class="champ" id="daty1" value="<%=daty1%>"></td>
            <td class="left">daty2:</td>
            <td> <input name="daty2" type="text" class="champ" id="daty2" value="<%=daty2%>"></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><strong><font color="#FF0000" size="+1">TRIER
        PAR </font></strong></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Colonne :</td>
            <td align="center"> <select name="colonne" class="champ" id="colonne">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp;
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="ordre">
                <option value="ASC" <%=(ordre.compareTo("ASC")==0?"selected":"") %>>Croissante</option>
                <option value="DESC" <%=(ordre.compareTo("DESC")==0?"selected":"") %>>Décroissante</option>
              </select>
            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><strong>Solde initial:</strong> <input type="text" name="soldeInitial" value="<%=soldeInitial%>">
            </td>
          </tr>
        </table></td>
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
<!-- RECAPITULATION -->
<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td align="rigth" bgcolor="#C300FF"><strong></strong></td>
          <td align="center">Nombre</td>
          <td align="center">Somme RECPREV</td>
          <td align="center">Somme RECEFF</td>
          <td align="center">SOLDEREC</td>
          <td align="center">Somme DEPPREV</td>
          <td align="center">Somme DEPEFF</td>
          <td align="center">SOLDEDEP</td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="center"><strong><%=lesMontants[6] %></strong></td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[0]) %> </td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[1]) %> </td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[2]) %> </td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[3]) %> </td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[4]) %> </td>
          <td align="center"><%=Utilitaire.formaterAr(lesMontants[5]) %></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
<br />
<!-- LISTE -->
<form action="apreschoixLC.jsp" methode="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="10%" valign="top"><div align="center">Daty</div></td>
          <td width="10%" valign="top"><div align="center"><strong>SOLDE_INIT_TH</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>SOLDE_INIT_PR</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>REC_PREV</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>REC_EFF</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>ECART_REC</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>DEP_PREV</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>DEP_EFF</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>ECART_DEP</strong></div></td>
        </tr>
        <%
  if(la!=null){
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#EAEAEA'" height="20px">
          <td align="center" valign="top"><div align="center"><%=Utilitaire.datetostring(la[i].getDaty())%></div></td>
          <td align="center" valign="top"><div align="center"><%=Utilitaire.formaterAr(la[i].getSoldeth())%></a></div></td>
          <td align="center" valign="top"><div align="center"><%=Utilitaire.formaterAr(la[i].getSoldepr())%></a></div></td>
          <td align="center" valign="top"><div align="center"><a href="../<%=lien%>?but=prevision/groupePrevisionRecette.jsp&daty1=<%=Utilitaire.datetostring(la[i].getDaty())+"&daty2="+Utilitaire.datetostring(la[i].getDaty())%>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(la[i].getRec_prev())%></a></div></td>
          <td align="center" valign="top"><div align="center"><a href="../<%=lien%>?but=finance/groupeMvtCaisse.jsp&daty1=<%=Utilitaire.datetostring(la[i].getDaty())+"&daty2="+Utilitaire.datetostring(la[i].getDaty())+"&debit1=0&debit2=0"%>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(la[i].getRec_eff())  %></a></div></td>
          <td align="center" valign="top"><div align="center"><%=Utilitaire.formaterAr(la[i].getEcart_rec() )  %></a></div></td>
          <td align="center" valign="top"><div align="center"><a href="../<%=lien%>?but=prevision/groupePrevisionDepense.jsp&daty1=<%=Utilitaire.datetostring(la[i].getDaty())+"&daty2="+Utilitaire.datetostring(la[i].getDaty())%>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(la[i].getDep_prev())%></a></div></td>
          <td align="center" valign="top"><div align="center"><a href="../<%=lien%>?but=finance/groupeMvtCaisse.jsp&daty1=<%=Utilitaire.datetostring(la[i].getDaty())+"&daty2="+Utilitaire.datetostring(la[i].getDaty())+"&credit1=0&credit2=0"%>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(la[i].getDep_eff())%></a></div></td>
          <td align="center" valign="top"><div align="center"><%=Utilitaire.formaterAr(la[i].getEcart_dep() )  %></a></div></td>
        </tr>
        <%
  }
  }
  %>
</table>
</form>
<br />
<!--PAGINATION-->
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
        <tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=la.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=Math.floor(la.length/nbParPazy)+1%></td>
        </tr>
            <tr>
            <td width="295" valign="top" height="25">
                <%if(pazy>1){%>
                <a href="analysePrevision.jsp?<%=suivant%>&pazy=<%=(pazy-1)%>">&lt;&lt;Page
                      pr&eacute;c&eacute;dente</a>
                <%
                }

           %></td>
           <td width="305" align="right">
             <%
             if(pazy<nbPage){
             %>
             <a href="analysePrevision.jsp?<%=suivant%>&pazy=<%=(pazy+1)%>">Page
             suivante&gt;&gt;</a>
             <%
            }
              %></td>
          </tr>
</table>

<br />
