function isInt(s)
{
    if(s=="")return "";
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) throw "Nombre non valide";
    }
    return parseInt(s,10);
}
function isNombre(sText)
{
    if(s=="")return "";
    sText=sText.replace(",",".");
    var deuxpartie=sText.split(",");
    if(deuxpartie.length>2) throw "nombre non valide";
    isInt(deuxpartie[0]);
    isInt(deuxpartie[1]);
    return parseFloat(sText);
}
function replaceAll(text,old,nouv)
{
    while(text.indexOf(old)>-1)
        text = text.replace(old,nouv);
    return text;
    
}
function date(sText)
{
    if(sText=="")return "";
    var sep =new Array();
    sep.push(".");sep.push("/");sep.push(":");
    sText=replaceAll(sText,sep[0],sep[1]);
    sText=replaceAll(sText,sep[2],sep[1]);
    var listeSplit=sText.split(sep[1]);
    var nombreSep=listeSplit.length-1;
    if(nombreSep>2) throw "Format date non valide";
    var taille=sText.length;
    var retour="";
    if(taille==1)
    {
        isInt(taille);
        retour="01/01/200"+taille;
    }
    if(taille==2)
    {
        var chiffre="";
        var i=0;
        for(i=0;i<sep.length;i++)
        {
            var indice=sText.indexOf(sep[i]);
            if(indice!=-1) 
            {
                chiffre=sText.substring(indice,sText.length);
                break;            
            }
        }
        if(chiffre=="")retour="01/01/20"+sText;
        else retour="01/01/200"+chiffre;
        
    }
    if(taille==3)
    {
        var chiffre="";
        var indice=sText.indexOf(sep[1]);
        if(indice!=-1) 
        {
            chiffre=sText.substring(indice+1,sText.length);
        }
        if(chiffre=="")retour="0"+sText.substring(0,1)+"/0"+sText.substring(1,2)+"/200"+sText.substring(2,3);
        else retour="01/01/20"+chiffre;
        
    }
    if(nombreSep==0)
    {
        if(taille==4)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var annee=sText.substring(2,4);
            var mois="0"+sText.substring(1,2);
            var jour="0"+sText.substring(0,1);
            if(mois=="00")
            {
                annee="0"+sText.substring(3,4);
                mois=sText.substring(1,3);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==5)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var avantAnnee=sText.substring(2,3);
            var annee=sText.substring(3,5);
            var jour="0"+sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==6)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,6);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12)
            {
                annee=sText.substring(2,6);
                mois="0"+sText.substring(1,2);
                jour="0"+sText.substring(0,1);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==7)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(3,7);
            var jour=sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            if(jour>31) throw "format de date invalide";
            retour=jour+"/"+mois+"/"+annee;

        }
        if(taille==8)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,8);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12||jour>31)
            {
                throw "Format de date invalide";
            }
            retour=jour+"/"+mois+"/"+annee;

        }
        if(taille>8)throw "Format de date non valide";
    }
    if(nombreSep==1)
    {
        var annee=completerAnnee(listeSplit[1]);
        var mois=completerAvantCaractere(listeSplit[0],"0",2);
        var jour="01";
        if(mois>12)
        {
            annee=new Date().getFullYear();
            mois=completerAvantCaractere(listeSplit[1],"0",2);
            jour=completerAvantCaractere(listeSplit[0],"0",2);
        }
        retour=jour+"/"+mois+"/"+annee;
    }
    if(nombreSep==2)
    {
        var annee=completerAnnee(listeSplit[2]);
        var mois=completerAvantCaractere(listeSplit[1],"0",2);
        var jour=completerAvantCaractere(listeSplit[0],"0",2);
        if(mois>12||jour>31)
        {
            throw "Format de date invalide";
        }
        retour=jour+"/"+mois+"/"+annee;
    }
    testDateValide(retour);
 
    return retour;
}
function completerAnnee(annee)
{
    if(annee.length==2 && annee>69) 
    {
        annee="19"+annee;
    }
    else if (annee.length<=2)
    {
        if(annee.length==2)
            annee="20"+annee;
        if(annee.length==1)
            annee="200"+annee;
    }
    return annee;
}
function completerAvantCaractere(mot,car,nombre)
{
    while(mot.length<nombre)
    {
        mot=car+mot;
    }
    return mot;
}
function getMaxJour(mois,annee)
{
    if(mois==4||mois==6 ||mois==9||mois==11) return 30;
    if(mois==2&&((annee%4==0&&annee%100!=0)||annee%400==0)) return 29;
    else if(mois==2) return 28;
    return 31;    
}
function testDateValide(retour)
{
    var listeChiffre=retour.split("/");
    for(k=0;k<listeChiffre.length;k++)
    {
        isInt(listeChiffre[k]);
    }
    var annee=parseInt(listeChiffre[2]);
    var mois=parseInt(listeChiffre[1]);
    var jour=parseInt(listeChiffre[0]);
    if(jour>getMaxJour(mois,annee)||jour<0||jour==0||mois==0||annee==0) throw "Date invalide";
}
function required(sText)
{
    sText = trim(sText);
    if((sText!=null)&&(sText!=''))
        return sText;
    else
        throw "Ce champ doit être renseigné";   
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}


function tel(sText)
{
   sText = trim(sText);
   var ret =  "Format de téléphone non valide";
   
   if(!isInt(sText))
           throw  ret;
   
   var reg = /^\d*[0-9](|.\d*[0-9]|,\d*[0-9])?$/;
    if(!reg.test(sText))
        return true;
    else
        throw ret;   
}




