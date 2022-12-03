<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String lien=null;
        String acte=null;
        String designation=null;
        String idTypeLc=null;
        String mois=null;
        String direction=null;
        String numCompte=null;
        String entite=null;
        String rmq=null;
        String idLigneACopier=null;
        String paruInf,paruSup;
        String annee;
        String credit;
        String mois2,annee2;
        String idLigne;
        String creditIni;
        String creditMod;
        String dir;

%>
<%
	acte=request.getParameter("acte");
    designation=request.getParameter("designation");
    idTypeLc=request.getParameter("idTypeLC");
    mois=request.getParameter("mois");
    mois2=request.getParameter("mois2");
    direction=request.getParameter("direction");
    numCompte=request.getParameter("numeroc");
    entite=request.getParameter("entite");
    rmq=request.getParameter("rmq");//idLigneACopier
    paruInf=request.getParameter("paruInf");
    paruSup=request.getParameter("paruSup");
    annee = request.getParameter("annee");
    annee2 = request.getParameter("annee2");
    credit = request.getParameter("credit");

    idLigne = request.getParameter("idLigne");
    creditIni= request.getParameter("creditIni");
    creditMod= request.getParameter("creditMod");
    dir= request.getParameter("dir");
    System.out.println("NC "+numCompte);
    try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
           if (acte.compareToIgnoreCase("insertLC")==0)
          {
            // public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup) throws Exception;
          String id = u.createLCRecette(designation,credit,idTypeLc,numCompte,entite,direction,mois,annee,"1");
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/creerLCRecette.jsp&msg=Une ligne de credit a été insérer (Id:<%=id %>)."); </script>
           <%
          }
          if (acte.compareToIgnoreCase("copieLC")==0)
         {
           // public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup) throws Exception;
         String id = u.copierLCRecette(mois, annee, mois2, annee2);
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeLC2Recette.jsp"); </script>
          <%
          }

          if (acte.compareToIgnoreCase("update")==0)
          {
            // public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup) throws Exception;
         //   System.out.println(idLigne+"   ||     "+designation+"   ||     "+ creditIni+"   ||     "+creditMod+"   ||     "+idTypeLc+"   ||     "+numCompte+"   ||     "+entite+"   ||     "+direction+"   ||     "+mois+"   ||     "+annee);
        u.updateLC(idLigne,  designation,  creditIni,  creditMod,  idTypeLc,  numCompte,  entite,  direction,  mois,  annee,"ligneCreditRecette");
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/visualiserDetailLCRecette.jsp&numObjet=<%=idLigne%>"); </script>
           <%
           }

        }

    catch (Exception e){
      e.printStackTrace();
 %>

<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
		<%
		return;
		}
		%>
</html>






