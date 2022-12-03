<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.Cheque" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  user.UserEJB u=null;
  String lien;
  String idMvt=null;
  int montantAr=0;
  Cheque[] ch = null;
  Cheque cq=null;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
idMvt=request.getParameter("numcheque");
cq=new Cheque();
cq.setNomTable("chequeetat");
cq.setNumCheque(idMvt);
ch=(Cheque[])CGenUtil.rechercher(cq,null,null,"");
if(ch.length==0) throw new Exception("Le cheque nexiste pas");
%>
<p class="titre">&nbsp;</p>
<h1>Details ch&egrave;que</h1>
<form action="<%=lien%>?but=finance/apresVirerCheque.jsp" method="post" target="_parent">
  <table width="350" border="0" align="center" cellpadding="0">
    <tr>
    <td class="titre">     <br>
        <input name="acte" type="hidden" id="acte" value="INSERT"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td height="22" class="tete-tableau"><div align="right"><strong>id mvt </strong></div></td>
            <td><div align="center"><%=ch[0].getId()%></div></td>
          </tr>
          <tr>
            <td width="184" height="22" class="tete-tableau"><div align="right"><strong>id virement </strong></div></td>
            <td width="276">
            <div align="center"><%=ch[0].getIdMvt()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>date saisie </strong></div></td>
            <td>
              <div align="center"><%=ch[0].getDatySaisieLettre()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>date Valeur</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getDatyValeurLettre()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>Designation</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getDesignation()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>remarque</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getRemarque()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>numero ch&egrave;que </strong></div></td>
            <td>
              <div align="center"><%=ch[0].getNumCheque()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>caisse</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getCaisse()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>montant</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getMontantLettre()%></div></td>
          </tr>
          <tr>
            <td height="26" class="tete-tableau"><div align="right"><strong>etat</strong></div></td>
            <td>
              <div align="center"><%=ch[0].getEtat()%></div></td>
          </tr>
        </table></td>
  </tr>

  <tr>
  <%if(ch[0].getEtat().compareTo("nonvire")==0){%>
      <td align="center"><input type="submit" name="Submit" value="Virer" class="submit"></td>
      <td>&nbsp;</td>
   <%}%>
   <%if(ch[0].getEtat().compareTo("nonvise")==0){%>
      <td align="center"><a href="<%=lien+"?but=finance/viserVir.jsp&numObjet="+ch[0].getIdMvt()%>"><input type="button" name="Submit" value="Viser" class="submit"></a></td>
      <td>&nbsp;</td>
   <%}%>
  </tr>
  <tr>

     <input name="idVrt" type="hidden" id="idVrt" value="<%=ch[0].getId()%>">
     <input name="IdMvt" type="hidden" id="IdMvt" value="<%=ch[0].getIdMvt()%>">
     <input name="datySaisieLettre" type="hidden" id="datySaisieLettre" value="<%=ch[0].getDatySaisieLettre()%>">
     <input name="datyValeurLettre" type="hidden" id="datyValeurLettre" value="<%=ch[0].getDatyValeurLettre()%>">
     <input name="ordre" type="hidden" id="ordre" value="<%=ch[0].getDesignation()%>">
     <input name="remarque" type="hidden" id="remarque" value="<%=ch[0].getRemarque()%>">
     <input name="numCheque" type="hidden" id="numCheque" value="<%=ch[0].getNumCheque()%>">
     <input name="caisse" type="hidden" id="caisse" value="<%=ch[0].getCaisse()%>">
     <input name="montantLettre" type="hidden" id="montantLettre" value="<%=ch[0].getMontantLettre() %>">
     <input name="montant" type="hidden" id="mont" value="<%=ch[0].getMontant() %>">
  </tr>
</table>
</form>
