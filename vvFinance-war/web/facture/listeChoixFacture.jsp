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

%>
<%
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         client = request.getParameter("client");
         idEtat = request.getParameter("etat");
         idCatServ = request.getParameter("idCat");
         idSsCatServ = request.getParameter("sscat");
	 numFact = request.getParameter("numFact");
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (numFact==null || numFact.compareTo("")==0) numFact="%";
	  if (client==null || client.compareTo("")==0) client="%";
         if ((idEtat==null)|| idEtat.compareTo("")==0) idEtat="eta4";
         if ((idCatServ==null)|| idCatServ.compareTo("")==0) idCatServ="%";
         if ((idSsCatServ==null)|| idSsCatServ.compareTo("")==0) idSsCatServ="%";
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
fm = u.findFactureMereNonPaye(datyinf,datySup,numFact,client,"","eta4",idCatServ,idSsCatServ);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister choix facture</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>
<form action="<%=lien%>?but=facture/listeChoixFacture.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Type :</td>
            <td><select name="idCat" class="champ" id="idCat">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<cat.length;i++){
          %>
                <option value=<%=cat[i].getId()%> <%if(cat[i].getId().compareTo(idCatServ)==0)out.println("selected");%>><%=cat[i].getVal()%></option>
                <%
         }
          %>
              </select> </td>
            <td class="left">Sous-cat&eacute;gorie :</td>
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
            <td class="left">Etat :</td>
            <td><!--<select name="etat" class="champ" id="etat">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<etat.length;i++){
          %>
                <option value="<%=etat[i].getId()%>" <%if(idEtat.compareTo(etat[i].getId())==0 || idEtat.compareTo("eta4")==0)out.println("selected");%>><%=etat[i].getVal()%></option>
                <%
                }
                %>
              </select> -->
			  finalis&eacute;</td>
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
<br>
 <form action="<%=lien%>?but=finance/entree.jsp" method="post">

  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td><div align="center">
          <input name="Submit2" type="submit" class="submit" value="Choisir">
        </div></td>
    </tr>
 </table>   <br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <!--DWLayoutTable-->
  <tr>
    <td align="center">

      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td  height="25" align="center">Facture N&deg;</td>
          <td width="69" align="center">Date</td>
          <td align="center" width="159">Client</td>
          <td align="center" width="81">Etat</td>
            <td width="119" align="center" valign="middle">Montant</td>
        </tr>
        <%
  for(int i=0;i<fm.length;i++){

%>
        <tr>
          <td align="center" width="24"><input type="radio" name="idFacture" value="<%=fm[i].getIdFactureMere()%>"></td>
          <td  height="25" align="center" width="144"><a href="<%=lien%>?idFactureMere=<%=fm[i].getIdFactureMere()%>&but=facture/detailFacture.jsp"><%=fm[i].getIdFactureMere()%></a></td>
          <td align="center" width="69"><%=Utilitaire.formatterDaty(fm[i].getDaty())%></td>
          <td align="center" width="159"><%=u.findClient(fm[i].getIdClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0].getNom()%></td>
          <td align="center" width="81"><%=u.findTypeObjet("etat",fm[i].getIdEtat(),"%")[0].getVal()%></td>
          <td width="119" valign="middle" bgcolor="#FFFFFF"><div align="center">&nbsp;<%=Utilitaire.formaterAr((double)fm[i].getMontantAPayer())%>&nbsp;<%=fm[i].getIdFactureEn()%></div></td>
        </tr>
        <%
    }

  %>
      </table>
 </td>
</tr>
</table>

</form>

<br>
<script language="javascript">
var cal1 = new calendar1(document.forms['listeFact'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeFact'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
