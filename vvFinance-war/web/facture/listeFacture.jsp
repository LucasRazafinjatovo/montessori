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
        bean.TypeObjet[] ag = null;
        bean.TypeObjet dev[] = null;
        String devi=null;
        String numFactLien=null;
        String agence=null;
        String entite=null;
        TypeObjet enti[] =null;

%>
<%
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         client = request.getParameter("client");
         idEtat = request.getParameter("etat");
         idCatServ = request.getParameter("idCat");
         idSsCatServ = request.getParameter("sscat");
	 numFact = request.getParameter("numFact");
         devi=request.getParameter("devi");
         agence=request.getParameter("agence");
          if ((agence==null)|| agence.compareTo("")==0) agence="%";
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (numFact==null || numFact.compareTo("")==0) numFact="%";
	  if (client==null || client.compareTo("")==0) client="%";
         if ((idEtat==null)|| idEtat.compareTo("")==0) idEtat="%";
         if ((idCatServ==null)|| idCatServ.compareTo("")==0) idCatServ="%";
         if ((idSsCatServ==null)|| idSsCatServ.compareTo("")==0) idSsCatServ="%";
         if ((devi==null)|| devi.compareTo("")==0) devi="%";
         entite=request.getParameter("entite");
          if ((entite==null)|| entite.compareTo("")==0) entite="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");

lien=(String)session.getValue("lien");
//String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService
//fm = u.findFactureMere(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ);
etat = u.findTypeObjet("Etat","%","%");
cat = u.findTypeObjet("Categorie","%","%");
scatserv = u.findSCatService("%","%","%","%");
ut=u.getUser();
dev = u.findTypeObjet("Devise","%","%");
//public FactMere[] findFactureMereDeviseRespEntite(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp, String entite) throws Exception, RemoteException;
fm = u.findFactureMereDeviseRespEntite(datyinf,datySup,numFact,client,"",idEtat,idCatServ,idSsCatServ,devi,agence,entite);
numFactLien=numFact;
ag = u.findTypeObjet("Agence","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
//findFactureMereDevise(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise)
}catch(Exception e){e.printStackTrace();
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
            <td class="left">Etat :</td>
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
            <td><input name="numFact" type="text" class="champ" id="numFact4" size="10" value="<%=numFact%>">
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
<%
  if (numFact==null || numFact.compareTo("%")==0) numFact="";
            if (client==null || client.compareTo("%")==0) client="";
           if ((idCatServ==null)|| idCatServ.compareTo("%")==0) idCatServ="";
         if ((idSsCatServ==null)|| idSsCatServ.compareTo("%")==0) idSsCatServ="";
            if ((devi==null)|| devi.compareTo("%")==0) devi="";
%>
<br>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <!--DWLayoutTable-->
  <tr>
    <td align="center">
      <p align="center"><strong><u>RECAPITULATION</u></strong></p>
        <%
      for (int i=0;i<enti.length;i++)
      {if(facture.AdminFacture.getNombreFactureEntite(fm,enti[i].getId())!=0){%>
            <p align="left"><strong><%=enti[i].getVal()%>:</strong></p>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
      <%for (int k=0;k<dev.length;k++)
      {
        if(facture.AdminFacture.getNombreFactureEntiteDevise(fm,dev[k].getId(),enti[i].getId())!=0){
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
          <td width="151" align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommeFactureGroupeEntite(fm,dev[k].getId(),enti[i].getId()))%> <%=" "+dev[k].getId()%></td>
          <td width="86" align="center"><div align="right"></div></td>
          <td width="105" align="left">&nbsp;<strong> Nombre</strong> :<%=facture.AdminFacture.getNombreFactureEntiteDevise(fm,dev[k].getId(),enti[i].getId())%> </td>
          <td width="131" align="left"><div align="center"><a href="<%=lien%>?but=facture/detailListeFacture.jsp&devi=<%=dev[k].getId()%>&datyinf=<%=datyinf %>&datySup=<%=datySup%>&client=<%=Utilitaire.remplacePourcentage(client)%>&etat=<%=Utilitaire.remplacePourcentage(idEtat)%>&idCat=<%=idCatServ%>&sscat=<%=idSsCatServ%>&numFact=<%=Utilitaire.remplacePourcentage(numFact)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&entite=<%=enti[i].getId()%>">D&eacute;tails</a></div></td>
        </tr>
        <%}
          }%>
      </table>
      <%}}%>
      <br>
<p align="left"><strong>Total :</strong></p>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <%for (int k=0;k<dev.length;k++)
      {
        if(facture.AdminFacture.getNombreFacture(fm,dev[k].getId())!=0){
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
          <td width="131" align="left"><div align="center"><a href="<%=lien%>?but=facture/detailListeFacture.jsp&devi=<%=dev[k].getId()%>&datyinf=<%=datyinf %>&datySup=<%=datySup%>&client=<%=Utilitaire.remplacePourcentage(client)%>&etat=<%=Utilitaire.remplacePourcentage(idEtat)%>&idCat=<%=idCatServ%>&sscat=<%=idSsCatServ%>&numFact=<%=Utilitaire.remplacePourcentage(numFact)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&entite=<%=Utilitaire.remplacePourcentage(entite)%>">D&eacute;tails</a></div></td>
        </tr>
        <%
          }}%>
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
