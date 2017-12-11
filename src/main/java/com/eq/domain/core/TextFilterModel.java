package java.com.eq.domain.core;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * TextFilterModel
 */
public class TextFilterModel implements FilterModel {
    private String fieldName = null;
    @JsonProperty("type")
    private TypeEnum type = null;
    @JsonProperty("filter")
    private String filter = null;

    public String getFieldName() {
        return fieldName;
    }

    public TextFilterModel setFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public TextFilterModel fieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public TextFilterModel type(TypeEnum type) {
        this.type = type;
        return this;
    }

    /**
     * The filter type. The type of text filter to apply. One of [&#39;equals&#39;, &#39;notEqual&#39;, &#39;contains&#39;, &#39;notContains&#39;, &#39;startsWith&#39;, &#39;endsWith&#39;].
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

    public TextFilterModel filter(String filter) {
        this.filter = filter;
        return this;
    }

    /**
     * The actual filter number to apply, or the start of the range if the filter type is inRange.
     *
     * @return filter
     **/
    @JsonProperty("filter")
    public String getFilter() {
        return filter;
    }

    public void setFilter(String filter) {
        this.filter = filter;
    }

    /**
     * The filter type. The type of text filter to apply. One of [&#39;equals&#39;, &#39;notEqual&#39;, &#39;contains&#39;, &#39;notContains&#39;, &#39;startsWith&#39;, &#39;endsWith&#39;].
     */
    public enum TypeEnum {
        EQUALS("equals"),

        NOTEQUAL("notEqual"),

        CONTAINS("contains"),

        NOTCONTAINS("notContains"),

        STARTSWITH("startsWith"),

        ENDSWITH("endsWith");

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

