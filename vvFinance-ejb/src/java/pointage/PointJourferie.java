package pointage;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

public class PointJourferie extends ClassMAPTable{
    private String id;
    private Date daty;
    private String type,designation,remarque, heure_debut, heure_fin;


    public String getTuppleID() {
        return id;
    }


    public String getAttributIDName() {
        return "id";
    }


    public void construirePK(Connection c) throws Exception {

        this.preparePk("PJF", "GETSEQPOINTJOURFERIE");
        this.setId(makePK(c));
    }
     public PointJourferie() {
        super.setNomTable("point_jourferie");
    }
     public PointJourferie(String id,Date daty,String type,String designation,String remarque, String heure_debut, String heure_fin) throws Exception{
        this.setId(id);
        this.setDaty(daty);
        this.setType(type);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        this.setHeure_debut(heure_debut);
        this.setHeure_fin(heure_fin);
        super.setNomTable("point_jourferie");
    }
    public PointJourferie(String id,Date daty,String type,String designation,String remarque) throws Exception{
        this.setId(id);
        this.setDaty(daty);
        this.setType(type);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        super.setNomTable("point_jourferie");
    }
    public PointJourferie(Date daty,String type,String designation,String remarque) throws Exception{
        this.setDaty(daty);
        this.setType(type);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        super.setNomTable("point_jourferie");
    }
    public void setId(String id) {
        this.id = id;
    }

    public void setDaty(Date daty) throws Exception {
        if ((getMode().compareToIgnoreCase("modif") == 0) && daty == null) {
            throw new Exception("Champ date obligatoire");
        }
        this.daty = daty;
    }

    public void setType(String type){
        this.type = type;
    }

    public void setDesignation(String designation) throws Exception {
        if ((getMode().compareToIgnoreCase("modif") == 0) && (designation == null || designation.compareToIgnoreCase("") == 0)) {
            throw new Exception("Champ designation obligatoire");
        }
        this.designation = designation;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getId() {
        return id;
    }

    public Date getDaty() {
        return daty;
    }

    public String getType() {
        return type;
    }

    public String getDesignation() {
        return designation;
    }

    public String getRemarque() {
        return remarque;
    }

    public String getHeure_debut() {
        return heure_debut;
    }

    public void setHeure_debut(String heure_debut) throws Exception {
        if ((getMode().compareToIgnoreCase("modif") == 0) && (heure_debut == null || heure_debut.compareToIgnoreCase("") == 0)) {
            throw new Exception("Heure debut obligatoire");
        }
        if ((getMode().compareToIgnoreCase("modif") == 0) && heure_debut != null && !validateTime(heure_debut)) {
            throw new Exception("Heure debut saisi non valide");
        }
        this.heure_debut = heure_debut;
    }

    public String getHeure_fin() {
        return heure_fin;
    }

    public void setHeure_fin(String heure_fin) throws Exception {
        if ((getMode().compareToIgnoreCase("modif") == 0) && (heure_fin == null || heure_fin.compareToIgnoreCase("") == 0)) {
            throw new Exception("Heure fin obligatoire");
        }
        if ((getMode().compareToIgnoreCase("modif") == 0) && heure_fin != null && !validateTime(heure_fin)) {
            throw new Exception("Heure fin saisi non valide");
        }
        this.heure_fin = heure_fin;
    }

    //
    private boolean validateTime(String timeString) throws Exception {
        if ((timeString.length() != 5) && (timeString.length() != 8)) {
            return false;
        }
        if (!timeString.substring(2, 3).equals(":")) {
            return false;
        }
        int hour = validateNumber(timeString.substring(0, 2));
        int minute = validateNumber(timeString.substring(3, 5));
        int second = 0;
        if (timeString.length() == 8) {
            validateNumber(timeString.substring(6));
        }
        if (hour < 0 || hour >= 24) {
            return false;
        }
        if (minute < 0 || minute >= 60) {
            return false;
        }
        if (second < 0 || second >= 60) {
            return false;
        }
        return true;
    }

    private int validateNumber(String numberString) {
        try {
            int number = Integer.valueOf(numberString).intValue();
            return number;
        } catch (NumberFormatException e) {
            return -1;
        }
    }

}
