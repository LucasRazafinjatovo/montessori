<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

	String apres="facture/listeFacture.jsp";
	String lien= null;
	facture.FactMere fm[] = null;
	String datyinf = null;
 	String datySup = null;
  	String idFactureMere = null;
  	String dateLimite = null;
	String idEtat = null;
	String idCatServ = null;
        String idSsCatServ = null;
        SCatService scatserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
	TypeObjet cat[] = null;
        Client clt = null;
	String numFact = null;
        String client = null;
	String role = null;
        historique.MapUtilisateur ut=null;
        bean.TypeObjet fact = null;
        bean.TypeObjet dev[] = null;
        bean.TypeObjet ag[] = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
        String devi = null;
        TypeObjet devizy = null;
        String agence=null;
        String entite=null;
        TypeObjet enti[] =null;

%>
<%
         datyinf = request.getParameter("datyinf");
         datySup = request.getParameter("datySup");
         client = request.getParameter("client");
         idEtat = request.getParameter("etat");
         idCatServ = request.getParameter("idCat");
         idSsCatServ = request.getParameter("sscat");
	 numFact = request.getParameter("numFact");
         devi = request.getParameter("devi");
         pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
         agence=request.getParameter("agence");
          if ((agence==null)|| agence.compareTo("")==0) agence="%";
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (numFact==null || numFact.compareTo("")==0) numFact="%";
         if (client==null || client.compareTo("")==0) client="%";
         if ((idEtat==null)|| idEtat.compareTo("")==0) idEtat="%";
         if ((idCatServ==null)|| idCatServ.compareTo("")==0) idCatServ="%";
         if ((idSsCatServ==null)|| idSsCatServ.compareTo("")==0) idSsCatServ="%";
         // if (devi==null || devi.compareTo("")==0) devi="%";
          entite=request.getParameter("entite");
          if ((entite==null)|| entite.compareTo("")==0) entite="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService
//fm = u.findFactureMere(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ);
devizy=u.findTypeObjet("devise",devi,"%")[0];
etat = u.findTypeObjet("Etat","%","%");
cat = u.findTypeObjet("Categorie","%","%");
scatserv = u.findSCatService("%","%","%","%");
ut=u.getUser();
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
//fm = u.findFactureMereDeviseResp(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ,devi,agence);
fm = u.findFactureMereDeviseRespEntite(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ,devi,agence,entite);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les factures</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>
<form action="<%=lien%>?but=facture/listeFacture.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Type :</td>
            <td><select name="sscat" class="champ"  id="sscat">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<scatserv.length;i++){
          %>
                <option value=<%=scatserv[i].getIdScatService()%> <%if(scatserv[i].getIdScatService().compareTo(idSsCatServ)==0)out.println("selected");%>><%=scatserv[i].getNomSCatService()%></option>
                <%
                }
                %>
              </select> </td>
            <td class="left">Sous-cat&eacute;gorie :</td>
            <td><select name="etat" class="champ" id="select">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<etat.length;i++){
          %>
                <option value="<%=etat[i].getId()%>" <%if(idEtat.compareTo(etat[i].getId())==0 || idEtat.compareTo("eta4")==0)out.println("selected");%>><%=etat[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
          </tr>
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=datyinf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin:</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Client :</td>
            <td><input name="client" type="text" class="champ" id="client" value="<%=client%>"> </td>
            <td class="left">Num. Facture :</td>
            <td><input name="numFact" type="text" class="champ" id="numFact4" value="<%=numFact%>">
            </td>
          </tr>
                  <tr>
            <td class="left">Agence :</td>
            <td><select name="agence" class="champ" id="agence">
                <option value="%" <%if(agence.compareTo("%")==0) out.println("selected");%>>Tous</option>
                <%
                  for(int i=0;i<ag.length;i++){
%>
                <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo(agence)==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                <%
                  }
%>
              </select> </td>
             <td class="left">Entité :</td>
            <td><select name="entite" class="champ" id="entite">
                <option value="%" <%if(entite.compareTo("%")==0) out.println("selected");%>>Tous</option>
                <%
                  for(int i=0;i<enti.length;i++){
%>
                <option value="<%=enti[i].getId()%>" <%if(enti[i].getId().compareTo(entite)==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                <%
                  }
%>
              </select>
            </td>
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
<br>
   <%
  if (numFact==null || numFact.compareTo("%")==0) numFact="";
            if (client==null || client.compareTo("%")==0) client="";
           if ((idCatServ==null)|| idCatServ.compareTo("%")==0) idCatServ="";
         if ((idSsCatServ==null)|| idSsCatServ.compareTo("%")==0) idSsCatServ="";
%>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <!--DWLayoutTable-->
  <tr>
    <td align="center">
      <p align="center"><strong><u>RECAPITULATION</u></strong></p>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <%

      for (int k=0;k<dev.length;k++)
      {
       if(facture.AdminFacture.getNombreFacture(fm,dev[k].getId())>0){
       %>

        <tr class="head">
          <td  height="25" align="center" bgcolor="#C300FF"><strong><%=dev[k].getVal()%></strong> </td>
          <td align="center"><div align="right">Montant</div></td>
          <td align="center">&nbsp;</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td width="123"  height="25" align="center"><strong>Total <%=dev[k].getVal()%> :</strong></td>
          <td width="151" align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommeFactureGroupe(fm,dev[k].getId()))%> <%=" "+dev[k].getId()%></td>
          <td width="86" align="center"><div align="right"></div></td>
          <td width="105" align="left">&nbsp;<strong> Nombre</strong> :<%=facture.AdminFacture.getNombreFacture(fm,dev[k].getId())%> </td>
        </tr>
        <%
          }
      }%>
      </table>

      <br>
      <strong>LISTE</strong> <br>
      <br>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">


          <td  height="25" align="center">Facture N&deg;</td>

    <td width="139" align="center"><div align="right">Montant</div></td>

        <td width="67" align="center">Date</td>

        <td align="center" width="122">Client</td>

        <td align="center" width="72">Etat</td>

          <td width="103" align="center" valign="middle">Type</td>
 <%
      if((ut.getIdrole().compareTo("admin"))==0)
		{
   %>

          <td width="24"></td>
<%
	}
	%>

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
%>
<%
  for(int i=pazy1;i<pazy2;i++){
  %>

  <tr>


          <td  height="25" align="center" width="69"><a href="<%=lien%>?idFactureMere=<%=fm[i].getIdFactureMere()%>&but=facture/detailFacture.jsp"><%=fm[i].getIdFactureMere()%></a></td>

    <td width="139" align="right"> <%=Utilitaire.formaterAr((double)fm[i].getMontantAPayer())%><%=" "+fm[i].getIdFactureEn()%></td>

    <td align="center" width="67">&nbsp;&nbsp;<%=Utilitaire.formatterDaty(fm[i].getDaty())%></td>

    <td align="center" width="122"><%=fm[i].getIdClient()%></td>

    <td align="center" width="72"><%=u.findTypeObjet("etat",fm[i].getIdEtat(),"%")[0].getVal()%></td>

    <td width="103" valign="middle" bgcolor="#FFFFFF"><div align="center">&nbsp;<%=u.findSCatService(fm[i].getIdSCatService(),"%","%","%")[0].getNomSCatService()%>&nbsp;</div></td>

 <%
      if((ut.getIdrole().compareTo("admin"))==0)
		{
   %>
    <td width="24" align="center" valign="middle"><a href="#">An</a>.</td>

<%

	}
	%>
  </tr>

   <%
    }

  %>
   <tr>


          <td  height="2" align="center"></td>

          <td width="139" align="right"></td>

          <td width="67" align="center"></td>

          <td align="center" width="122"></td>

          <td align="center" width="72"></td>

          <td width="103" align="center" valign="middle"></td>
 <%
      if((ut.getIdrole().compareTo("admin"))==0)
		{
   %>

          <td width="24" bgcolor="#ffffff"></td>
<%
	}
	%>

  </tr>

</table>
      <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=fm.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%if(fm.length%nbParPazy==0)out.println(fm.length/nbParPazy);else out.println(fm.length/nbParPazy+1);%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facture/detailListeFacture.jsp&devi=<%=devizy.getId()%>&pazy=<%=pazy-1%>&datyinf=<%=datyinf %>&datySup=<%=datySup%>&client=<%=Utilitaire.remplacePourcentage(client)%>&etat=<%=Utilitaire.remplacePourcentage(idEtat)%>&idCat=<%=idCatServ%>&sscat=<%=idSsCatServ%>&numFact=<%=Utilitaire.remplacePourcentage(numFact)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&entite=<%=Utilitaire.remplacePourcentage(entite)%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(fm.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/detailListeFacture.jsp&devi=<%=devizy.getId()%>&pazy=<%=pazy%>&datyinf=<%=datyinf %>&datySup=<%=datySup%>&client=<%=Utilitaire.remplacePourcentage(client)%>&etat=<%=Utilitaire.remplacePourcentage(idEtat)%>&idCat=<%=idCatServ%>&sscat=<%=idSsCatServ%>&numFact=<%=Utilitaire.remplacePourcentage(numFact)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&entite=<%=Utilitaire.remplacePourcentage(entite)%>">Page
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
var cal1 = new calendar1(document.forms['listeFact'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeFact'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
