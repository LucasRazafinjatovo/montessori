<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<link href="style.css" rel="stylesheet" type="text/css">


<%!
     UserEJB u = null;
     String lien =null;
     String numObjet=null;
     String typeObjet=null;
     String montantObjet=null;
     String[]idLcArecup=null;
     String[] montant=null;
     String   liste=null;
     String acte=null;
     String idUnion=null;
     int nb=0;
%>
<%
try
{
  nb=Utilitaire.stringToInt(request.getParameter("nb"));
  montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";
  acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="update";
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  idUnion=request.getParameter("idUnion");
lien	= (String)session.getValue("lien");
u	= (UserEJB)session.getAttribute("u");
montant=new String[nb];
idLcArecup=new String[nb];
for (int i=0;i<idLcArecup.length;i++)
{
   idLcArecup[i]=request.getParameter("idLC"+i);
   montant[i]=request.getParameter("montant"+i);
   if((montant[i]==null)||(montant[i].compareToIgnoreCase("")==0))montant[i]="0";
 }
 //public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant) throws Exception {

  if(acte.compareToIgnoreCase("update")==0) {
    u.updateMontantUnionIntraLcPrev("PREVDEPENSELC",numObjet,idLcArecup,montant);
  }
  if(acte.compareToIgnoreCase("delete")==0) u.deleteUnionIntraTableLcOp(Constante.tableOrFcLc,"FACTURECLIENTLC",idUnion);
  if(acte.compareToIgnoreCase("svalide")==0){
    u.validerMappageLCPrevDepControle("PREVDEPENSELC",numObjet);
  }
 %>
<script language="JavaScript"> document.location.replace("<%=lien %>?but=prevision/ventilationPrevLcDepense.jsp&numObjet=<%=numObjet%>&typeor=<%=request.getParameter("typeor")%>"); </script>
<%
}
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>

