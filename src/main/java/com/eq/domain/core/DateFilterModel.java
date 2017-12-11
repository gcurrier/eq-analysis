package java.com.eq.domain.core;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;

import java.time.Instant;

/**
 * DateFilterModel
 */
public class DateFilterModel implements FilterModel {

    private String fieldName = null;
    @JsonProperty("type")
    private TypeEnum type = null;
    @JsonProperty("date")
    private Instant date = null;
    @JsonProperty("dateTo")
    private Instant dateTo = null;

    public DateFilterModel fieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public String getFieldName() {
        return fieldName;
    }

    public DateFilterModel setFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public DateFilterModel type(TypeEnum type) {
        this.type = type;
        return this;
    }


    /**
     * The filter type. The type of date filter to apply. One of [&#39;equals&#39;, &#39;notEquals&#39;, &#39;lessThanOrEqual&#39;, &#39;greaterThan&#39;, &#39;greaterThanOrEqual&#39;, &#39;inRange&#39;]
     *
     * @return type
     **/
    @JsonProperty("type")
    public TypeEnum getType() {
        return type;
    }

    public void setType(TypeEnum type) {
        this.type = type;
    }

    public DateFilterModel date(Instant date) {
        this.date = date;
        return this;
    }

    /**
     * The actual filter date to apply, or the start of the range if the filter type is inRange.
     *
     * @return date
     **/
    @JsonProperty("date")
    public Instant getDate() {
        return date;
    }

    public void setDate(Instant date) {
        this.date = date;
    }

    public DateFilterModel dateTo(Instant dateTo) {
        this.dateTo = dateTo;
        return this;
    }

    /**
     * The end range of the filter if the filter type is inRange, otherwise has no effect.
     *
     * @return dateTo
     **/
    @JsonProperty("dateTo")
    public Instant getDateTo() {
        return dateTo;
    }

    public void setDateTo(Instant dateTo) {
        this.dateTo = dateTo;
    }

    /**
     * The filter type. The type of date filter to apply. One of [&#39;equals&#39;, &#39;notEquals&#39;, &#39;lessThanOrEqual&#39;, &#39;greaterThan&#39;, &#39;greaterThanOrEqual&#39;, &#39;inRange&#39;]
     */
    public enum TypeEnum {
        EQUALS("equals"),

        NOTEQUALS("notEquals"),

        LESSTHANOREQUAL("lessThanOrEqual"),

        GREATERTHAN("greaterThan"),

        GREATERTHANOREQUAL("greaterThanOrEqual"),

        INRANGE("inRange");

        private String value;

        TypeEnum(String value) {
            this.value = value;
        }

        @JsonCreator
        public static TypeEnum fromValue(String text) {
            for (TypeEnum b : TypeEnum.values()) {
                if (String.valueOf(b.value).equals(text)) {
                    return b;
                }
            }
            return null;
        }

        @Override
        @JsonValue
        public String toString() {
            return String.valueOf(value);
        }
    }

}

