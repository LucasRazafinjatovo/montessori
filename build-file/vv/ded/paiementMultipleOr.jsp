<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        String typeObjet = null;
        String[] idOr;
        double montant;
        String listeOr=null;
     %>
<%
typeObjet=request.getParameter("typeObjet");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
montant=0;
idOr=request.getParameterValues("id");
if(idOr.length!=0){
listeOr = idOr[0];
OrdonnerPayement o = new OrdonnerPayement();
o.setNomTable("orapayer");
OrdonnerPayement[] op=(OrdonnerPayement[])CGenUtil.rechercher(o,null,null," and id='"+idOr[0]+"'");
montant = op[0].getMontant();
for(int i=1;i<idOr.length;i++)
{
  if(idOr[i].compareTo(idOr[i-1])!=0)  {
    listeOr+="<br/>"+idOr[i];
    OrdonnerPayement[] lfp=(OrdonnerPayement[])CGenUtil.rechercher(o,null,null," and id='"+idOr[i]+"'");
    montant = montant + lfp[0].getMontant();
  }
  else{
    i++;
  }

}%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/mvtCaisseRecette.jsp&numObjet=<%=listeOr%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montant%>"); </script>
<%}else{%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=selectionner au moins un OR"); </script>
 <% }
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>