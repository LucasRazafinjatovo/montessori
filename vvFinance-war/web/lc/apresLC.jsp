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
          String id = u.createLcMultiple(designation,credit,idTypeLc,numCompte,entite,direction,mois,annee,paruInf,paruSup, "ligneCredit");
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/creerLC.jsp&msg=Une ligne de credit a été insérer (Id:<%=id %>)."); </script>
           <%
          }
          if (acte.compareToIgnoreCase("copieLC")==0)
         {
           // public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup) throws Exception;
         String id = u.copierLC(mois, annee, mois2, annee2, "ligneCredit");
          %>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/listeLC2.jsp"); </script>
          <%
          }

          if (acte.compareToIgnoreCase("update")==0)
          {
            // public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup) throws Exception;
         //   System.out.println(idLigne+"   ||     "+designation+"   ||     "+ creditIni+"   ||     "+creditMod+"   ||     "+idTypeLc+"   ||     "+numCompte+"   ||     "+entite+"   ||     "+direction+"   ||     "+mois+"   ||     "+annee);
        u.updateLC(idLigne,  designation,  creditIni,  creditMod,  idTypeLc,  numCompte,  entite,  direction,  mois,  annee,"ligneCredit");
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/visualiserDetailLC.jsp&numObjet=<%=idLigne%>"); </script>
           <%
           }
			if(acte.compareToIgnoreCase("dupliquer")==0){
              int n_dupl = Integer.parseInt(request.getParameter("nbPR"));
              String numObjet = request.getParameter("numObjet");
			  String classeLC = request.getParameter("classeLC");
			   String apresDupl = request.getParameter("apresDupl");
			  
              String[] montantTab = new String[n_dupl];
              String[] lmois = new String[n_dupl];
              String[] lannee = new String[n_dupl];
              String[] remarque = new String[n_dupl];
              for(int i = 0; i < n_dupl; i++){
                lmois[i] = request.getParameter("mois"+i);
                lannee[i] = request.getParameter("annee"+i);
                remarque[i] = request.getParameter("remarque"+i);
                montantTab[i] = request.getParameter("montant"+i);
              }
             
                 u.dupliquerLC(numObjet,montantTab, n_dupl, lmois, lannee, remarque, classeLC);
              %>
              <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/<%=apresDupl%>.jsp");</script>
            <%}
			if(acte.compareToIgnoreCase("dupliquerMultiple")==0){
              int n_dupl = Integer.parseInt(request.getParameter("nbPR"));
			  String classeLC = request.getParameter("classeLC");
			  String apresDupl = request.getParameter("apresDupl");


              String[] montantTab = new String[n_dupl];
			  String[] ids = new String[n_dupl];
              String[] lmois = new String[n_dupl];
              String[] lannee = new String[n_dupl];
              String[] remarque = new String[n_dupl];
              for(int i = 0; i < n_dupl; i++){
                lmois[i] = request.getParameter("mois"+i);
                lannee[i] = request.getParameter("annee"+i);
				ids[i] = request.getParameter("id"+i);
                remarque[i] = request.getParameter("remarque"+i);
                montantTab[i] = request.getParameter("montant"+i);
              }
             
                 u.dupliquerLCMultiple(ids,montantTab, n_dupl, lmois, lannee, remarque, classeLC);
              %>
              <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/<%=apresDupl%>.jsp");</script>
            <%}
        }

    catch (Exception e){
 %>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
		<%
		return;
		}
		%>
</html>






