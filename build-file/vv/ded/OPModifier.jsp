<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="ded.Visa" %>
<%@ page import="ded.OpLc" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresVisualiserOrdonnerPayement.jsp";
        String lien= null;
                facture.Client clt[] = null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
                TypeObjet ag[] =null;
        Caisse caiss[] = null;
                String idFact = null;
                facture.Tva tva = null;
                                String nature=null;
String numObjet = null;
double montantObjet = 0.0;
OrdonnerPayement op = null;
boolean estVisable=false;
Visa vi=null;
OpLc[] listeLc=null;
OrdonnerPayement oop = null;
OrdonnerPayement[] lop=null;
     %>
<%
String indiceSelection=request.getParameter("indice");
montantObjet = 0.0;

idFact=request.getParameter("num");
if(idFact==null||idFact.compareToIgnoreCase("")==0)idFact=request.getParameter("idOP");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";

if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
if(idFact==null || idFact.compareTo("")==0) throw new Exception("OP vide");
op=u.findOp(idFact,"%","%","","","","","%")[0];
 montantObjet =  op.getMontant();
 estVisable=op.estVisable();
        vi=op.getVisa();
OpLc crto=new OpLc();
crto.setNomTable("OPLCCalc");
crto.setId(idFact);
listeLc=(OpLc[])CGenUtil.rechercher(crto,null,null,"");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Detail Ordonner Payement </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
           <td class="left">Op id : </td>
           <td align="center"><%=op.getId() %></td>
         </tr>
         <tr>
            <td width="34%" class="left">Facture num : <span class="remarque">*</span></td>
            <td width="66%" align="center"> <%=op.getDed_Id()%>
                          </td>
          </tr>
          <tr>
            <td class="left">Montant (HT) : </td>
            <td align="center"><%=Utilitaire.formaterAr(op.getMontant())%>
                          </td>
          </tr>
          <tr>
            <td class="left">Designation : </td>
            <td align="center"> <%=op.getRemarque()%></td>
          </tr>
          <tr>
            <td class="left">Etat : </td>
            <td align="center"><%=op.getEtatLettre()%></td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
<input name="idDED" type="hidden" id="idDED" value="<%=op.getDed_Id()%>">
<input name="numObjet" type="hidden" id="numObjet" value="<%=op.getId()%>">
                          <input name="montantObjet" type="hidden" id="montantObjet" value="<%=montantObjet%>">
                         <input name="typeObjet" type="hidden" id="typeObjet" value="<%=nature%>">
<input name="idLc" type="hidden" id="idLc" value="<%=op.getIdLigne()%>">

  </tr>
</table>
    </td>
        </tr>
</table>

LISTE DES LIGNES CREDITS RELATIFS<br>
<table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
<tr class="head">
         <td width="20%" align="right"><div align="center">Designation</div></td>
         <td width="10%" align="right"><div align="center">entite  </div></td>
          <td width="10%" align="right"><div align="center">type </div></td>
           <td width="20%" align="right"><div align="center">Montant op avant  </div></td>
          <td width="20%" align="right"><div align="center">Montant apres </div></td>
          <td width="20%" align="right"><div align="center">Credit prevu </div></td>
          <td width="20%" align="right"><div align="center"></div></td>
</tr>
<%
for(int y=0;y<listeLc.length;y++){
  double encours=listeLc[y].getMontant();
  if(vi!=null) encours=0;
%>
<tr>
<td  align="right"><div align="center"><%=listeLc[y].getDesignationLc() %> </div></td>
         <td align="right"><div align="center"><%=listeLc[y].getIdEntite() %></div></td>
          <td  align="right"><div align="center"><%=listeLc[y].getIdTypeLigne()%></div></td>
           <td align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getMontantVis()) %></div></td>
          <td  align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getMontantVis()+encours)%></div></td>
          <td  align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getCreditModifier()) %></div></td>
          <td align="right"><div align="center"><a href="<%=lien%>?but=ded/LCModifier.jsp&idligne=<%=listeLc[y].getIdLigne()%>&numFact=<%=op.getDed_Id()%>&num=<%=idFact%>">Modifier</a></div></td>
</tr>
<%}%>
</table>
</form>