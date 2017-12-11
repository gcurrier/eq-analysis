package java.com.eq.domain.eq;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "EQ_EVENT")
public class EqEvent {
    @Transient
    public static final String RESPONSE_KEY = "events";

    @JsonProperty("eqEvID")
    @Id
    @Column(name = "EQ_EVENT_ID")
    private String eqEvID = null;

    @JsonProperty("evDataID")
    @Column(name = "EVENT_DATA_ID")
    private String evDataID = null;

    @JsonProperty("usgsID")
    @Column(name = "ID")
    private String usgsID = null;

    @JsonProperty("mag")
    @Column(name = "MAGNITUDE")
    private BigDecimal mag = null;

    @JsonProperty("place")
    @Column(name = "PLACE")
    private String place = null;

    @JsonProperty("evTime")
    @Column(name = "EVENT_TIME")
    private Date evTime = null;

    @JsonProperty("updtd")
    @Column(name = "UPDATED")
    private Date updtd = null;

    @JsonProperty("evtz")
    @Column(name = "EVENT_TZ")
    private BigDecimal evtz = null;

    @JsonProperty("felt")
    @Column(name = "FELT")
    private BigDecimal felt = null;

    @JsonProperty("cdi")
    @Column(name = "CDI")
    private BigDecimal cdi = null;

    @JsonProperty("mmi")
    @Column(name = "MMI")
    private BigDecimal mmi = null;

    @JsonProperty("alert")
    @Column(name = "ALERT")
    private String alert = null;

    @JsonProperty("tsnmi")
    @Column(name = "TSUNAMI")
    private BigDecimal tsnmi = null;

    @JsonProperty("sig")
    @Column(name = "SIG")
    private BigDecimal sig = null;

    @JsonProperty("net")
    @Column(name = "NET")
    private String net = null;

    @JsonProperty("code")
    @Column(name = "CODE")
    private String code = null;

    @JsonProperty("ids")
    @Column(name = "IDS")
    private String ids = null;

    @JsonProperty("srcs")
    @Column(name = "SOURCES")
    private String srcs = null;

    @JsonProperty("evTyps")
    @Column(name = "EVENT_TYPES")
    private String evTyps = null;

    @JsonProperty("nst")
    @Column(name = "NST")
    private BigDecimal nst = null;

    @JsonProperty("dmin")
    @Column(name = "DMIN")
    private BigDecimal dmin = null;

    @JsonProperty("rms")
    @Column(name = "RMS")
    private BigDecimal rms = null;

    @JsonProperty("gap")
    @Column(name = "GAP")
    private BigDecimal gap = null;

    @JsonProperty("mgTyp")
    @Column(name = "MAGTYPE")
    private String mgTyp = null;

    @JsonProperty("evTyp")
    @Column(name = "EVENT_TYPE")
    private String evTyp = null;

    @JsonProperty("lng")
    @Column(name = "LONGITUDE")
    private String lng = null;

    @JsonProperty("lat")
    @Column(name = "LATITUDE")
    private String lat = null;

    @JsonProperty("dpth")
    @Column(name = "DEPTH")
    private BigDecimal dpth = null;

    @JsonProperty("evUrl")
    @Column(name = "EVENT_URL")
    private String evUrl = null;

    @JsonProperty("evDet")
    @Column(name = "EVENT_DETAIL")
    private String evDet = null;

    @JsonProperty("evStat")
    @Column(name = "EVENT_STATUS")
    private String evStat = null;

    public EqEvent usgsID(String usgsID) {
        this.usgsID = usgsID;
        return this;
    }

    /**
     * EQ_EVENT_ID: Primary Key
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
     * EVENT_DATA_ID: Foreign Key to EVENT_DATA table
     *
     * @return evDataID
     **/
    @JsonProperty("evDataID")
    public String getEvDataID() {
        return evDataID;
    }

    public void setEvDataID(String evDataID) {
        this.evDataID = evDataID;
    }

    /**
     * ID: A unique identifier for the event. This is the current preferred id for the event, and may change over time
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
     * MAGNITUDE: The magnitude for the event. Learn more about magnitudes. [http://earthquake.usgs.gov/learn/glossary/?term&#x3D;magnitude](http://earthquake.usgs.gov/learn/glossary/?term&#x3D;magnitude)
     *
     * @return mag
     **/
    @JsonProperty("mag")
    public BigDecimal getMag() {
        return mag;
    }

    public void setMag(BigDecimal mag) {
        this.mag = mag;
    }

    /**
     * PLACE: Textual description of named geographic region near to the event. This may be a city name, or a Flinn-Engdahl Region (http://earthquake.usgs.gov/learn/topics/flinn_engdahl.php) name
     *
     * @return place
     **/
    @JsonProperty("place")
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    /**
     * EVENT_TIME: Time when the event occurred. Times are reported in milliseconds since the epoch (1970-01-01T00:00:00.000Z), and do not include leap seconds. In certain output formats, the date is formatted for readability
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
     * UPDATED: Time when the event was most recently updated. Times are reported in milliseconds since the epoch. In certain output formats, the date is formatted for readability
     *
     * @return updtd
     **/
    @JsonProperty("updtd")
    public Date getUpdtd() {
        return updtd;
    }

    public void setUpdtd(Date updtd) {
        this.updtd = updtd;
    }

    /**
     * EVENT_TZ: Timezone offset from UTC in minutes at the event epicenter
     *
     * @return evtz
     **/
    @JsonProperty("evtz")
    public BigDecimal getEvtz() {
        return evtz;
    }

    public void setEvtz(BigDecimal evtz) {
        this.evtz = evtz;
    }

    /**
     * FELT: The total number of felt reports submitted to the DYFI? [http://earthquake.usgs.gov/research/dyfi/](http://earthquake.usgs.gov/research/dyfi/) system
     *
     * @return felt
     **/
    @JsonProperty("felt")
    public BigDecimal getFelt() {
        return felt;
    }

    public void setFelt(BigDecimal felt) {
        this.felt = felt;
    }

    /**
     * CDI: The maximum reported intensity [http://earthquake.usgs.gov/learn/glossary/?term&#x3D;intensity](http://earthquake.usgs.gov/learn/glossary/?term&#x3D;intensity) for the event. Computed by DYFI [http://earthquake.usgs.gov/research/dyfi/](http://earthquake.usgs.gov/research/dyfi/). While typically reported as a roman numeral, for the purposes of this API, intensity is expected as the decimal equivalent of the roman numeral. Learn more about magnitude vs. intensity (http://earthquake.usgs.gov/learn/topics/mag_vs_int.php)
     *
     * @return cdi
     **/
    @JsonProperty("cdi")
    public BigDecimal getCdi() {
        return cdi;
    }

    public void setCdi(BigDecimal cdi) {
        this.cdi = cdi;
    }

    /**
     * MMI: The maximum estimated instrumental intensity [http://earthquake.usgs.gov/learn/glossary/?term&#x3D;intensity](http://earthquake.usgs.gov/learn/glossary/?term&#x3D;intensity) for the event. Computed by ShakeMap [http://earthquake.usgs.gov/research/shakemap/](http://earthquake.usgs.gov/research/shakemap/). While typically reported as a roman numeral, for the purposes of this API, intensity is expected as the decimal equivalent of the roman numeral. Learn more about magnitude vs. intensity (http://earthquake.usgs.gov/learn/topics/mag_vs_int.php)
     *
     * @return mmi
     **/
    @JsonProperty("mmi")
    public BigDecimal getMmi() {
        return mmi;
    }

    public void setMmi(BigDecimal mmi) {
        this.mmi = mmi;
    }

    /**
     * ALERT: The alert level from the PAGER earthquake impact scale [http://earthquake.usgs.gov/research/pager/](http://earthquake.usgs.gov/research/pager/)
     *
     * @return alert
     **/
    @JsonProperty("alert")
    public String getAlert() {
        return alert;
    }

    public void setAlert(String alert) {
        this.alert = alert;
    }

    /**
     * TSUNAMI: A flag value (0: non-oceanic event, 1: event occurrence in oceanic region)
     *
     * @return tsnmi
     **/
    @JsonProperty("tsnmi")
    public BigDecimal getTsnmi() {
        return tsnmi;
    }

    public void setTsnmi(BigDecimal tsnmi) {
        this.tsnmi = tsnmi;
    }

    /**
     * SIG: A number describing how significant the event is. Larger numbers indicate a more significant event. This value is determined on a number of factors, including: magnitude, maximum MMI, felt reports, and estimated impact
     *
     * @return sig
     **/
    @JsonProperty("sig")
    public BigDecimal getSig() {
        return sig;
    }

    public void setSig(BigDecimal sig) {
        this.sig = sig;
    }

    /**
     * NET: The ID of a data contributor. Identifies the network considered to be the preferred source of information for this event
     *
     * @return net
     **/
    @JsonProperty("net")
    public String getNet() {
        return net;
    }

    public void setNet(String net) {
        this.net = net;
    }

    /**
     * CODE: identifying code assigned by event source
     *
     * @return code
     **/
    @JsonProperty("code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    /**
     * IDS: A comma-separated list of event ids that are associated to an event
     *
     * @return ids
     **/
    @JsonProperty("ids")
    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    /**
     * SOURCES: comma separated list of network contributors
     *
     * @return srcs
     **/
    @JsonProperty("srcs")
    public String getSrcs() {
        return srcs;
    }

    public void setSrcs(String srcs) {
        this.srcs = srcs;
    }

    /**
     * TYPES: csv list of products associated with the event
     *
     * @return evTyps
     **/
    @JsonProperty("evTyps")
    public String getEvTyps() {
        return evTyps;
    }

    public void setEvTyps(String evTyps) {
        this.evTyps = evTyps;
    }

    /**
     * NST: The total number of seismic stations which reported P- and S-arrival times for this earthquake
     *
     * @return nst
     **/
    @JsonProperty("nst")
    public BigDecimal getNst() {
        return nst;
    }

    public void setNst(BigDecimal nst) {
        this.nst = nst;
    }

    /**
     * DMIN: horizontal distance from epicenter to nearest sensor station (in degrees) ~111.2 km per degree (the smaller this number, the more accurate the depth value)
     *
     * @return dmin
     **/
    @JsonProperty("dmin")
    public BigDecimal getDmin() {
        return dmin;
    }

    public void setDmin(BigDecimal dmin) {
        this.dmin = dmin;
    }

    /**
     * RMS: The root-mean-square (RMS) travel time residual, in sec, using all weights. This parameter provides a measure of the fit of the observed arrival times to the predicted arrival times for this location. Smaller numbers reflect a better fit of the data. The value is dependent on the accuracy of the velocity model used to compute the earthquake location, the quality weights assigned to the arrival time data, and the procedure used to locate the earthquake
     *
     * @return rms
     **/
    @JsonProperty("rms")
    public BigDecimal getRms() {
        return rms;
    }

    public void setRms(BigDecimal rms) {
        this.rms = rms;
    }

    /**
     * GAP: The largest azimuthal gap between azimuthally adjacent stations (in degrees). In general, the smaller this number, the more reliable is the calculated horizontal position of the earthquake
     *
     * @return gap
     **/
    @JsonProperty("gap")
    public BigDecimal getGap() {
        return gap;
    }

    public void setGap(BigDecimal gap) {
        this.gap = gap;
    }

    /**
     * MAGTYPE: The method or algorithm used to calculate the preferred magnitude for the event. Learn more about magnitude types [http://earthquake.usgs.gov/earthquakes/map/doc_aboutdata.php#magnitudes](http://earthquake.usgs.gov/earthquakes/map/doc_aboutdata.php#magnitudes)
     *
     * @return mgTyp
     **/
    @JsonProperty("mgTyp")
    public String getMgTyp() {
        return mgTyp;
    }

    public void setMgTyp(String mgTyp) {
        this.mgTyp = mgTyp;
    }

    /**
     * EVENT_TYPE (TYPE): type of seismic event (EARTHQUAKE, QUARRY)
     *
     * @return evTyp
     **/
    @JsonProperty("evTyp")
    public String getEvTyp() {
        return evTyp;
    }

    public void setEvTyp(String evTyp) {
        this.evTyp = evTyp;
    }

    /**
     * LONGITUDE: decimal degrees (negative values are western hemisphere)
     *
     * @return lng
     **/
    @JsonProperty("lng")
    public String getLong() {
        return lng;
    }

    public void setLong(String lng) {
        this.lng = lng;
    }

    /**
     * LATITUDE: decimal degrees (negative values are southern hemisphere)
     *
     * @return lat
     **/
    @JsonProperty("lat")
    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    /**
     * DEPTH: depth in kilometers
     *
     * @return dpth
     **/
    @JsonProperty("dpth")
    public BigDecimal getDpth() {
        return dpth;
    }

    public void setDpth(BigDecimal dpth) {
        this.dpth = dpth;
    }

    /**
     * EVENT_URL (URL): Link to USGS Event Page for event
     *
     * @return evUrl
     **/
    @JsonProperty("evUrl")
    public String getEvUrl() {
        return evUrl;
    }

    public void setEvUrl(String evUrl) {
        this.evUrl = evUrl;
    }

    /**
     * EVENT_DETAIL (DETAIL): Link to GeoJSON detail feed [http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson_detail.php](http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson_detail.php). NOTE: When searching and using geojson with callback, no callback is included in the detail url
     *
     * @return evDet
     **/
    @JsonProperty("evDet")
    public String getEvDet() {
        return evDet;
    }

    public void setEvDet(String evDet) {
        this.evDet = evDet;
    }

    /**
     * EVENT_STATUS (STATUS): indicates whether event has been reviewed by a human (AUTOMATIC,PUBLISHED,REVIEWED)
     *
     * @return evStat
     **/
    @JsonProperty("evStat")
    public String getEvStat() {
        return evStat;
    }

    public void setEvStat(String evStat) {
        this.evStat = evStat;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        EqEvent eqEvent = (EqEvent) o;
        return Objects.equals(eqEvID, eqEvent.eqEvID) &&
                Objects.equals(evDataID, eqEvent.evDataID) &&
                Objects.equals(usgsID, eqEvent.usgsID) &&
                Objects.equals(mag, eqEvent.mag) &&
                Objects.equals(place, eqEvent.place) &&
                Objects.equals(evTime, eqEvent.evTime) &&
                Objects.equals(updtd, eqEvent.updtd) &&
                Objects.equals(evtz, eqEvent.evtz) &&
                Objects.equals(felt, eqEvent.felt) &&
                Objects.equals(cdi, eqEvent.cdi) &&
                Objects.equals(mmi, eqEvent.mmi) &&
                Objects.equals(alert, eqEvent.alert) &&
                Objects.equals(tsnmi, eqEvent.tsnmi) &&
                Objects.equals(sig, eqEvent.sig) &&
                Objects.equals(net, eqEvent.net) &&
                Objects.equals(code, eqEvent.code) &&
                Objects.equals(ids, eqEvent.ids) &&
                Objects.equals(srcs, eqEvent.srcs) &&
                Objects.equals(evTyps, eqEvent.evTyps) &&
                Objects.equals(nst, eqEvent.nst) &&
                Objects.equals(dmin, eqEvent.dmin) &&
                Objects.equals(rms, eqEvent.rms) &&
                Objects.equals(gap, eqEvent.gap) &&
                Objects.equals(mgTyp, eqEvent.mgTyp) &&
                Objects.equals(evTyp, eqEvent.evTyp) &&
                Objects.equals(lng, eqEvent.lng) &&
                Objects.equals(lat, eqEvent.lat) &&
                Objects.equals(dpth, eqEvent.dpth) &&
                Objects.equals(evUrl, eqEvent.evUrl) &&
                Objects.equals(evDet, eqEvent.evDet) &&
                Objects.equals(evStat, eqEvent.evStat);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eqEvID, evDataID, usgsID, mag, place, evTime, updtd, evtz, felt, cdi, mmi, alert, tsnmi, sig, net, code, ids, srcs, evTyps, nst, dmin, rms, gap, mgTyp, evTyp, lng, lat, dpth, evUrl, evDet, evStat);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class EqEvent {\n");

        sb.append("    eqEvID: ").append(toIndentedString(eqEvID)).append("\n");
        sb.append("    evDataID: ").append(toIndentedString(evDataID)).append("\n");
        sb.append("    usgsID: ").append(toIndentedString(usgsID)).append("\n");
        sb.append("    mag: ").append(toIndentedString(mag)).append("\n");
        sb.append("    place: ").append(toIndentedString(place)).append("\n");
        sb.append("    evTime: ").append(toIndentedString(evTime)).append("\n");
        sb.append("    updtd: ").append(toIndentedString(updtd)).append("\n");
        sb.append("    evtz: ").append(toIndentedString(evtz)).append("\n");
        sb.append("    felt: ").append(toIndentedString(felt)).append("\n");
        sb.append("    cdi: ").append(toIndentedString(cdi)).append("\n");
        sb.append("    mmi: ").append(toIndentedString(mmi)).append("\n");
        sb.append("    alert: ").append(toIndentedString(alert)).append("\n");
        sb.append("    tsnmi: ").append(toIndentedString(tsnmi)).append("\n");
        sb.append("    sig: ").append(toIndentedString(sig)).append("\n");
        sb.append("    net: ").append(toIndentedString(net)).append("\n");
        sb.append("    code: ").append(toIndentedString(code)).append("\n");
        sb.append("    ids: ").append(toIndentedString(ids)).append("\n");
        sb.append("    srcs: ").append(toIndentedString(srcs)).append("\n");
        sb.append("    evTyps: ").append(toIndentedString(evTyps)).append("\n");
        sb.append("    nst: ").append(toIndentedString(nst)).append("\n");
        sb.append("    dmin: ").append(toIndentedString(dmin)).append("\n");
        sb.append("    rms: ").append(toIndentedString(rms)).append("\n");
        sb.append("    gap: ").append(toIndentedString(gap)).append("\n");
        sb.append("    mgTyp: ").append(toIndentedString(mgTyp)).append("\n");
        sb.append("    evTyp: ").append(toIndentedString(evTyp)).append("\n");
        sb.append("    _long: ").append(toIndentedString(lng)).append("\n");
        sb.append("    lat: ").append(toIndentedString(lat)).append("\n");
        sb.append("    dpth: ").append(toIndentedString(dpth)).append("\n");
        sb.append("    evUrl: ").append(toIndentedString(evUrl)).append("\n");
        sb.append("    evDet: ").append(toIndentedString(evDet)).append("\n");
        sb.append("    evStat: ").append(toIndentedString(evStat)).append("\n");
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

