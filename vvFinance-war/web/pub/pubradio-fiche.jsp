<%-- 
    Document   : pubradio-fiche
    Created on : 9 mai 2017, 16:41:57
    Author     : Doudou Tiarilala
--%>


<%@page import="utilitaire.Utilitaire"%> 
<%@page import="pub.PubTopRadio"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageConsulte"%>

<%!    PubTopRadio act;
    UserEJB u = null;
%>

<%
    u = (UserEJB) session.getValue("u");
    act = new PubTopRadio();
    //act.setNomTable("CONT_ORDRE_MISSION_LIBELLE");
    String[] libelleCessionFiche = {"id", "Nom client", "Campagne", "Type", "Date debut diffusion", "Date fin diffusion", "Reference pub","Confection pub", "Plage horaire","Duree"};
    PageConsulte pc = new PageConsulte(act, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    //pc.setLibAffichage(libelleCessionFiche);
    // pi.getFormu().getChamp("arrondissement").setVisible(false);
    //pc.getChampByName("DATEFIN").setVisible(false);
    //pc.getFormu().getChamp("duree").setVisible(false);
    //pc.getChampByName("arrondissement").setVisible(false);
    pc.setTitre("Fiche  pub radio ");
  
    //ContOMParticipant ctpp = new ContOMParticipant();
    // ctpp.setNomTable("CONT_OM_PARTICIPANT_LIBELLE");
    //ContOMParticipant[] part = (ContOMParticipant[]) u.getData(ctpp, null, null, null, " and id_om='" + request.getParameter("id") + "'");
    // ContEmpbenAcontroller[] ac = (ContEmpbenAcontroller[]) u.getData(new ContEmpbenAcontroller(), null, null, null, " and id_om='" + request.getParameter("id") + "'");

%>

<h1 class="box-title">Fiche type pub</h1>

<% out.println(pc.getHtml());%>

<p>

    <a href="<%=(String) session.getValue("lien") + "?but=pub/apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=pub/pubradio-liste.jsp&classe=pub.PubTopRadio"><button class="btn btn-pinterest pull-right" style="margin-right: 4px">Supprimer</button></a>&nbsp;&nbsp;&nbsp;
    <a href="<%=(String) session.getValue("lien") + "?but=pub/pubTopRadio-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-success pull-right" style="margin-right: 4px">Modifier</button></a>&nbsp;&nbsp;&nbsp;
   
</p>
