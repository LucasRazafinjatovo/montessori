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
  <table width="600" border="0" cellpadding="0">

  <tr>
      <td class="tuple-tableau"> <div align="left">
          <p><span class="remarque">&gt;&gt; Vous pouvez afficher la liste des
            factures selon les crit&egrave;res suivantes : </span><br>
            <span class="remarque">(*) Pour faire une recherche des factures r&eacute;alis&eacute;es
            entre deux dates, remplir les champs &quot;Date d&eacute;but&quot;
            et &quot;Date fin&quot;</span></p>
          <p><span class="remarque"><br>
            </span></p>
        </div></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td width="249" height="24" class="left"> <div align="right">Date
                d&eacute;but :</div></td>
            <td width="189" align="center"><input name="daty1" value="<%=daty1%>" type="text" class="champ" id="daty13">&nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td width="189" class="left"><div align="right">Date fin :</div></td>
            <td width="189"><div align="center">
                <input name="daty2" value="<%=daty2%>" type="text" class="champ" id="daty22">&nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </div></td>
          </tr>
          <tr>
            <td height="24" class="left"> <div align="right">Nom du client : </div></td>
            <td align="center"><input name="client" type="text" class="champ" id="client2" value=<%=client%>>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left"><div align="right">N&deg; Facture :</div></td>
            <td><div align="center">
                <input name="numFact" type="text" class="champ" id="numFact" value=<%=numFact%>>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td height="24" class="left"> <div align="right">Etat de paiement :</div></td>
            <td align="center"><select name="etat" class="champ" id="select3">
            <option value="tous" <%if(etat.compareTo("tous")==0)out.println("selected");%>>tous</option>
                <option value="oui" <%if(etat.compareTo("oui")==0)out.println("selected");%>>Paye</option>
                <option value="non" <%if(etat.compareTo("non")==0)out.println("selected");%>>Impaye</option>

              </select>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left"><div align="right">Agence :</div></td>
            <td align="center">
                <input name="agence" type="text" class="champ" id="agence" value="<%=agence%>">&nbsp;
            <img src="images/blank.gif" width="16" height="16" align="absmiddle">
                        </td>
          </tr>
                    <tr>
            <td height="24" class="left"><div align="right">Type :</div></td>
            <td align="center"> <select name="idType" class="champ"  id="idType">
            <option value="%" <%if(idType.compareTo("%")==0)out.println("selected");%>>tous</option>
                <%
          for(int i=0;i<sctserv.length;i++){
            if(sctserv[i].getIdCategorie().compareTo("cat2") != 0){
          %>
                <option value="<%=sctserv[i].getIdScatService()%>" <%if(sctserv[i].getIdScatService().compareTo(idType)==0)out.println("selected");%>><%=sctserv[i].getNomSCatService()%></option>
                <%
            }
          }
                %>
              </select>&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>

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
          <tr>
            <td height="24" class="left"> <div align="right">Parution :</div></td>
            <td align="center"><input name="parution" type="text" class="champ" id="parution" value="<%=parution%>">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
            <td class="left">&nbsp;</td>
            <td align="center">&nbsp;
                        </td>
          </tr>
        </table></td>
  </tr>
  <tr>
    <td><table width="100%" height="106" border="0" cellpadding="0">
          <tr>
            <td> <div align="right">
                <input name="Submit" type="submit" class="boutons" value="Afficher">
              </div></td>
            <td> <input name="Submit2" type="reset" class="boutons" value="Annuler">
            </td>
          </tr>
          <tr>
            <td colspan="2" class="tuple-tableau"> <div align="left">
                <script language="javascript">
var cal1 = new calendar1(document.forms['etatFact'].elements['daty1']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['etatFact'].elements['daty2']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
                <br>
                <br>
              </div></td>
          </tr>
        </table>
        <p align="center"><strong><u>RECAPITULATION</u></strong></p>
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
            <td><div align="right"><a href="<%=lien%>?but=finance/listeEntree.jsp&numPiece=<%=fac[i].getIdFactureMere()%>"><%=Utilitaire.formaterAr((double)(fac[i].getPaye()))%><%=" "+fac[i].getIdFactureEn()%></a>
              </div></td>
            <td><div align="right"><%=Utilitaire.formaterAr((double)(fac[i].getReste()))%> <%=" "+fac[i].getIdFactureEn()%></div></td>
          </tr>
          <%
        }
        %>
        </table>

      </td>
  </tr>
</table>
  <input name="numFact" type="hidden" id="numFact" value="<%=numFact%>">
</form>
<div align="center"><a href="finance/apercuListeEtatFacture.jsp?numFact=<%=Utilitaire.remplacePourcentage(numFact)%>&client=<%=Utilitaire.remplacePourcentage(client)%>&etat=<%=Utilitaire.remplacePourcentage(etat)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&daty2=<%=daty2%>&daty1=<%=daty1%>">Voir
  aperçu</a> </div>
</body>
</html>
