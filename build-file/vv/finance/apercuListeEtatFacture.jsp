<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/listeEtatFacture.jsp";
        String lien="modele.jsp";
        String valeur="";
        user.UserEJB u=null;
        String client,daty1,daty2,etat;
        String codeProduit;
        String numFact=null;
        facture.EtatFacture[] fac=null;
        bean.TypeObjet dev[]=null;
        String agence=null;
        String idType=null;
        facture.SCatService[] sctserv=null;
        String entite=null;
        String parution=null;
        bean.TypeObjet enti[] =null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String num, String numFact, String client, String prod, String daty1, String daty2
numFact=request.getParameter("numFact");
client=request.getParameter("client");
daty1=request.getParameter("daty1");
daty2=request.getParameter("daty2");
etat=request.getParameter("etat");
agence=request.getParameter("agence");
idType=request.getParameter("idType");
parution=request.getParameter("parution");
sctserv = u.findSCatService("%", "%", "%", "%");

if ((parution==null)||parution.compareTo("")==0) parution="%";
if ((numFact==null)||numFact.compareTo("")==0) numFact="%";
if ((idType==null)||idType.compareTo("")==0) idType="%";
if ((agence==null)||agence.compareTo("")==0) agence="%";
if ((client==null)||client.compareTo("")==0) client="%";
if ((daty1==null)||daty1.compareTo("")==0) daty1="";
if ((daty2==null)||daty2.compareTo("")==0) daty2="";
if ((etat==null)||etat.compareTo("")==0) etat="";
         entite=request.getParameter("entite");
          if ((entite==null)|| entite.compareTo("")==0) entite="%";
          dev = u.findTypeObjet("Devise","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");
fac=u.findEtatFactureRespTypeEntite(numFact,daty1,daty2,etat,client,agence,idType,entite,parution);
%>
 
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>LISTE DES FACTURES</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" name="etatFact">
  <table width="600" border="0" cellpadding="0" align="center">
    <tr>
      <td> <p align="center"><strong><u>RECAPITULATION</u></strong></p>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <%
      for (int k=0;k<dev.length;k++){
        if (facture.AdminFacture.getNombreFacture(fac,dev[k].getId())>0)
      {%>
          <tr class="head">
            <td  height="25" align="center" bgcolor="#C300FF"><strong><%=dev[k].getVal()%></strong> </td>
            <td align="center">Montant</td>
            <td align="center">Avoir</td>
            <td align="center">Paye</td>
            <td align="center">Impaye</td>
            <td></td>
          </tr>
          <tr>
            <td width="69"  height="25" align="center"><strong>Tot. <%=dev[k].getVal()%> :</strong></td>
            <td width="117" align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommeEtatFacture(fac,dev[k].getId()))%> <%=" "+dev[k].getId()%></td>
            <td width="102" align="center"><div align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommeAvoirFacture(fac,dev[k].getId()))%><%=" "+dev[k].getId()%></div></td>
            <td width="113" align="center"><div align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommePayeFacture(fac,dev[k].getId()))%><%=" "+dev[k].getId()%></div></td>
            <td width="117" align="center"><div align="right"><%=Utilitaire.formaterAr((double)AdminFacture.calculSommeImPayeFacture(fac,dev[k].getId()))%><%=" "+dev[k].getId()%></div></td>
            <td width="74" align="left">&nbsp;<strong> Nbre</strong> :<%=facture.AdminFacture.getNombreFacture(fac,dev[k].getId())%> </td>
          </tr>
          <% }}%>
        </table>
        <p align="center"><strong><u>LISTE</u></strong></p>
        <table width="100%" border="0" cellspacing="0" class="monographe">
          <tr class="head">
            <td width="11%" height="22"><div align="center">N&deg; Fact.</div></td>
            <td width="11%"><div align="center">Client</div></td>
            <td width="10%"><div align="center">Parution</div></td>
            <td width="18%" align="right"> <div align="center">Montant</div></td>
            <td width="15%" align="right"><div align="center">Avoir</div></td>
            <td width="17%" align="right"> <div align="center">Paye</div></td>
            <td width="18%" align="right"> <div align="center">ImPaye</div></td>
          </tr>
          <%
        for(int i=0;i<fac.length;i++)
        {
        %>
          <tr>
            <td><div align="center"><a href="<%=lien%>?but=facture/detailFacture.jsp&idFactureMere=<%=fac[i].getIdFactureMere()%>"><%=fac[i].getIdFactureMere()%></a></div></td>
            <td><div align="center"><%=fac[i].getClient()%></div></td>
            <td><div align="center"><%=fac[i].getParution()%></div></td>
            <td><div align="center">
                <div align="right"><%=Utilitaire.formaterAr((double)(fac[i].getMontant()))%><%=" "+fac[i].getIdFactureEn()%> </div>
              </div></td>
            <td><div align="right"><%=Utilitaire.formaterAr((double)(fac[i].getAvoir()))%><%=" "+fac[i].getIdFactureEn()%> </div></td>
            <td><div align="right"><%=Utilitaire.formaterAr((double)(fac[i].getPaye()))%><%=" "+fac[i].getIdFactureEn()%> </div></td>
            <td><div align="right"><%=Utilitaire.formaterAr((double)(fac[i].getReste()))%> <%=" "+fac[i].getIdFactureEn()%></div></td>
          </tr>
          <%
        }
        %>
        </table></td>
    </tr>
  </table>
  <input name="numFact" type="hidden" id="numFact" value="<%=numFact%>">
</form>
<div align="center"></div>
</body>
</html>
