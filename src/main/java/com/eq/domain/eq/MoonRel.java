package java.com.eq.domain.eq;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "EVENT_MOON_RELATION")
public class MoonRel {
    @Transient
    public static final String RESPONSE_KEY = "mrels";

    @JsonProperty("relID")
    @Id
    @Column(name = "REL_ID")
    private String relID = null;

    @JsonProperty("evDataID")
    @Column(name = "EVENT_DATA_ID")
    private String evDataID = null;

    @JsonProperty("eqEvID")
    @Column(name = "EQ_EVENT_ID")
    private String eqEvID = null;

    @JsonProperty("usgsID")
    @Column(name = "USGS_ID")
    private String usgsID = null;

    @JsonProperty("evTime")
    @Column(name = "EQ_EVENT_TIME")
    private Date evTime = null;

    @JsonProperty("mDist")
    @Column(name = "MOON_DIST")
    private String mDist = null;

    @JsonProperty("mDecl")
    @Column(name = "MOON_DECL")
    private String mDecl = null;

    @JsonProperty("mRasc")
    @Column(name = "MOON_RA")
    private String mRasc = null;

    /**
     * REL_ID: Primary Key
     *
     * @return relID
     **/
    @JsonProperty("relID")
    public String getRelID() {
        return relID;
    }

    public void setRelID(String relID) {
        this.relID = relID;
    }

    /**
     * EVENT_DATA_ID: Value used to identify relation to a specific data set from EQ_EVENT table.
     *
     * @return evDataID
     **/
    @JsonProperty("evDataID")
    @NotNull
    public String getEvDataID() {
        return evDataID;
    }

    public void setEvDataID(String evDataID) {
        this.usgsID = evDataID;
    }

    /**
     * EQ_EVENT_ID: Reference value to primary key of EQ_EVENT table.
     *
     * @return eqEvID
     **/
    @JsonProperty("eqEvID")
    public String getEqEvID() {
        return eqEvID;
    }

    public void setEqEvID(String eqEvID) {
        this.eqEvID = eqEvID;
    }

    /**
     * USGS_ID: A unique identifier for the event. This is the current preferred id for the event, and may change over time
     *
     * @return usgsID
     **/
    @JsonProperty("usgsID")
    @NotNull
    public String getUsgsID() {
        return usgsID;
    }

    public void setUsgsID(String usgsID) {
        this.usgsID = usgsID;
    }

    /**
     * EQ_EVENT_TIME: Time when the event occurred. Times are reported in milliseconds since the epoch (1970-01-01T00:00:00.000Z), and do not include leap seconds. In certain output formats, the date is formatted for readability
     *
     * @return evTime
     **/
    @JsonProperty("evTime")
    public Date getEvTime() {
        return evTime;
    }

    public void setEvTime(Date evTime) {
        this.evTime = evTime;
    }

    /**
     * MOON_DIST: A unique identifier for the event. This is the current preferred id for the event, and may change over time
     *
     * @return mDist
     **/
    @JsonProperty("mDist")
    @NotNull
    public String getMDist() {
        return mDist;
    }

    public void setMDist(String mDist) {
        this.mDist = mDist;
    }

    /**
     * MOON_DECL: The lunar declination angle as viewed from Greenwich, England
     *
     * @return mDecl
     **/
    @JsonProperty("mDecl")
    @NotNull
    public String getMDecl() {
        return mDecl;
    }

    public void setMDecl(String mDecl) {
        this.mDecl = mDecl;
    }

    /**
     * MOON_RA: The lunar Right Ascension angle as viewed from Greenwich, England
     *
     * @return mRasc
     **/
    @JsonProperty("mRasc")
    @NotNull
    public String getMRasc() {
        return mRasc;
    }

    public void setMRasc(String mRasc) {
        this.mRasc = mRasc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        MoonRel moonRel = (MoonRel) o;
        return Objects.equals(relID, moonRel.eqEvID) &&
                Objects.equals(evDataID, moonRel.evDataID) &&
                Objects.equals(eqEvID, moonRel.eqEvID) &&
                Objects.equals(usgsID, moonRel.usgsID) &&
                Objects.equals(evTime, moonRel.evTime) &&
                Objects.equals(mDist, moonRel.mDist) &&
                Objects.equals(mDecl, moonRel.mDecl) &&
                Objects.equals(mRasc, moonRel.mRasc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(relID, eqEvID, evDataID, usgsID, evTime, mDist, mDecl, mRasc);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class moonRel {\n");

        sb.append("    relID: ").append(toIndentedString(relID)).append("\n");
        sb.append("    eqEvID: ").append(toIndentedString(eqEvID)).append("\n");
        sb.append("    evDataID: ").append(toIndentedString(evDataID)).append("\n");
        sb.append("    usgsID: ").append(toIndentedString(usgsID)).append("\n");
        sb.append("    evTime: ").append(toIndentedString(evTime)).append("\n");
        sb.append("    mDist: ").append(toIndentedString(mDist)).append("\n");
        sb.append("    mDecl: ").append(toIndentedString(mDecl)).append("\n");
        sb.append("    mRasc: ").append(toIndentedString(mRasc)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
     * Convert the given object to string with each line indented by 4 spaces
     * (except the first line).
     */
    private String toIndentedString(Object o) {
        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n    ");
    }
}
