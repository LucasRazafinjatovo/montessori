<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>

<%
    EtudiantPromo pj = new EtudiantPromo();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    String idSociete = "SOC00003";

    affichage.Champ[] liste = new affichage.Champ[7];

    TypeObjet sexe = new TypeObjet();
    sexe.setNomTable("sexe");
    liste[0] = new Liste("sexe", sexe, "val", "id");

    TypeObjet pays = new TypeObjet();
    pays.setNomTable("PAYS");
    liste[1] = new Liste("pays", pays, "val", "id");

    Ecole ecole = new Ecole();
//ecole.setNomTable("ecole");
    liste[2] = new Liste("ecole", ecole, "nom", "id");

    TypeObjet prof1 = new TypeObjet();
    prof1.setNomTable("TYPEPROF");
    liste[3] = new Liste("proffPere", prof1, "val", "id");

    TypeObjet prof2 = new TypeObjet();
    prof2.setNomTable("TYPEPROF");
    liste[4] = new Liste("profMere", prof1, "val", "id");

    TypeObjet nature = new TypeObjet();
    nature.setNomTable("nature");
    liste[5] = new Liste("nature", nature, "val", "id");

    EntiteBeneficiaire entite = new EntiteBeneficiaire();
    entite.setIdSociete(idSociete);
    liste[6] = new Liste("entite", entite, "val", "id");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("nom").setLibelle("Nom ");
    pi.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom ");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse ");
    pi.getFormu().getChamp("contact").setLibelle("Contact *");
    pi.getFormu().getChamp("date_debut").setLibelle("Date entr�e");
  
    //pi.getFormu().getChamp("date_fin").setLibelle("Date sortie");
    //pi.getFormu().getChamp("date_fin").setDefaut("");
    pi.getFormu().getChamp("proffPere").setLibelle("Profession du p&egrave;re");
    pi.getFormu().getChamp("profMere").setLibelle("Profession de la m�re");
    pi.getFormu().getChamp("entite").setLibelle("Entit&eacute;");
    pi.getFormu().getChamp("niveau").setLibelle("Niveau");
    pi.getFormu().getChamp("nom").setType("texte");
    pi.getFormu().getChamp("prenom").setType("texte");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dateNaissance").setLibelle("Date naissance ");
    pi.getFormu().getChamp("dateNaissance").setTypeData("date");
    pi.getFormu().getChamp("dateNaissance").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dateNaissance").setDefaut(Utilitaire.dateDuJour());
//pi.getFormu().getChamp("dateNaissance").setAutre("onBlur=date(this.value)");
    pi.getFormu().getChamp("pere").setType("texte");
    pi.getFormu().getChamp("pere").setLibelle("P&egrave;re");
    pi.getFormu().getChamp("mere").setType("texte");
    pi.getFormu().getChamp("mere").setLibelle("M&egrave;re");
    pi.getFormu().getChamp("mail").setType("textarea");
    pi.getFormu().getChamp("mail").setLibelle("Adresse Mail");
    pi.getFormu().getChamp("contact").setType("texte");
    pi.getFormu().getChamp("niveau").setType("texte");
    pi.getFormu().getChamp("promotion").setValeur(request.getParameter("promotion"));
    pi.getFormu().getChamp("chemin").setLibelle("lieu de naissance");

    pi.getFormu().getChamp("date_debut").setVisible(false);
    pi.getFormu().getChamp("niveau").setVisible(false);
       pi.getFormu().getChamp("entite").setVisible(false);
  

//pi.getFormu().getChamp("optionne").setLibelle("Option etudiant(par defaut tronc commun)");
//pi.getFormu().getChamp("chemin").setVisible(false);
    pi.getFormu().getChamp("promotion").setVisible(false);
    pi.getFormu().getChamp("daty").setVisible(false);
    pi.getFormu().getChamp("date_fin").setVisible(false);
    pi.getFormu().getChamp("numero").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.preparerDataFormu();
%>

<h1>Saisir &eacute;tudiant</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="etudiant" id="etudiant">


    <%
        //pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/InscriptionAnneescolaireEtudiant.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.EtudiantPromo">
    <!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
<script language="javascript">
    var cal = new calendar1(document.forms['etudiant'].elements['dateNaissance']);
    cal.year_scroll = false;
    cal.time_comp = false;
</script>
