package java.com.eq.domain.core;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * NumberFilterModel
 */
public class NumberFilterModel implements FilterModel {
    private String fieldName = null;
    @JsonProperty("type")
    private TypeEnum type = null;
    @JsonProperty("filter")
    private Long filter = null;
    @JsonProperty("filterTo")
    private Long filterTo = null;

    public NumberFilterModel fieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public String getFieldName() {
        return fieldName;
    }

    public NumberFilterModel setFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public NumberFilterModel type(TypeEnum type) {
        this.type = type;
        return this;
    }

    /**
     * The filter type. The type of number filter to apply. One of [&#39;equals&#39;, &#39;notEquals&#39;, &#39;lessThanOrEqual&#39;, &#39;greaterThan&#39;, &#39;greaterThanOrEqual&#39;, &#39;inRange&#39;].
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

    public NumberFilterModel filter(Long filter) {
        this.filter = filter;
        return this;
    }

    /**
     * The actual filter number to apply, or the start of the range if the filter type is inRange.
     *
     * @return filter
     **/
    @JsonProperty("filter")
    public Long getFilter() {
        return filter;
    }

    public void setFilter(Long filter) {
        this.filter = filter;
    }

    public NumberFilterModel filterTo(Long filterTo) {
        this.filterTo = filterTo;
        return this;
    }

    /**
     * The end range of the filter if the filter type is inRange, otherwise has no effect.
     *
     * @return filterTo
     **/
    @JsonProperty("filterTo")
    public Long getFilterTo() {
        return filterTo;
    }

    public void setFilterTo(Long filterTo) {
        this.filterTo = filterTo;
    }


    /**
     * The filter type. The type of number filter to apply. One of [&#39;equals&#39;, &#39;notEquals&#39;, &#39;lessThanOrEqual&#39;, &#39;greaterThan&#39;, &#39;greaterThanOrEqual&#39;, &#39;inRange&#39;].
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

