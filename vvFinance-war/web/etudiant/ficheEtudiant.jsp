<%@page import="recette.ConfPrixEtudiant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
    Etudiant p;
    ConfPrixEtudiant conf;
    PaiementDetail paiementDetails;
    String lien = "note/ficheResultatOptionnel.jsp";
    String finLien = "";
    Parcours par = null;
    Parcours[] lp = null;
    String optionetu = "";
    UserEJB u = null;
    historique.MapUtilisateur ut = null;
%>
<%
    p = new Etudiant();
    p.setNomTable("etudiant");
    //String[] libelleConsultationFiche = {"Id", "Nom", "Prenom", "Date de naissance", "Nom du pere", "Proffession pere", "Nom de la mere", "Profession mere", "Adresse", "Contact", "Mail", "Chemin", "Sexe"};
    PageConsulte pc = new PageConsulte(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
//Etudiant e=(Etudiant)pc.getBase();
    //pc.setLibAffichage(libelleConsultationFiche);
    /*par= new Parcours();
     lp  = (Parcours[])CGenUtil.rechercher(par,null,null," and idetudiant='"+request.getParameter("id")+"' order by semestre");
     optionetu="";
     if(lp.length!=0) optionetu=lp[lp.length-1].getOptionetu();*/
    u = (user.UserEJB) session.getValue("u");
    ut = u.getUser();

%>
<html>
    <link href="../style/style.css" rel="stylesheet" type="text/css">
    <h1>Consultation d'une fiche &eacute;tudiant</h1>
    <table border=0>
        <tr>
            <td>
                <%String sary = request.getParameter("id");%>
                <img width="150" src="<%=request.getContextPath()%>/images/etudiant.png"  alt="loading">
            </td>
        </tr>
    </table>
    <%
        out.println(pc.getHtml());
    %>
    <a href="<%=(String) session.getValue("lien") + "?but=etudiant/modifEtudiant.jsp&id=" + request.getParameter("id")%>"><u>Modifier</u></a>
    <a href="<%=(String) session.getValue("lien") + "?but=etudiant/mouvement-etudiant.jsp&idetudiant=" + request.getParameter("id")%>"><u>Exit</u></a>
    <br/>

   
</html>
