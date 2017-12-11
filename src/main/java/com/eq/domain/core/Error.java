package java.com.eq.domain.core;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.Objects;

/**
 * Error
 */
public class Error {
    @JsonProperty("code")
    private Integer code = null;

    @JsonProperty("msg")
    private String msg = null;

    @JsonProperty("dtls")
    private String dtls = null;

    public Error code(Integer code) {
        this.code = code;
        return this;
    }

    /**
     * The error code.
     * minimum: 100
     * maximum: 600
     *
     * @return code
     **/
    @JsonProperty("code")
    @Min(100)
    @Max(600)
    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Error msg(String msg) {
        this.msg = msg;
        return this;
    }

    /**
     * A short message describing the error.
     *
     * @return msg
     **/
    @JsonProperty("msg")
    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Error dtls(String dtls) {
        this.dtls = dtls;
        return this;
    }

    /**
     * Detailed error text.
     *
     * @return dtls
     **/
    @JsonProperty("dtls")
    public String getDtls() {
        return dtls;
    }

    public void setDtls(String dtls) {
        this.dtls = dtls;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Error error = (Error) o;
        return Objects.equals(this.code, error.code) &&
                Objects.equals(this.msg, error.msg) &&
                Objects.equals(this.dtls, error.dtls);
    }

    @Override
    public int hashCode() {
        return Objects.hash(code, msg, dtls);
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class Error {\n");

        sb.append("    code: ").append(toIndentedString(code)).append("\n");
        sb.append("    msg: ").append(toIndentedString(msg)).append("\n");
        sb.append("    dtls: ").append(toIndentedString(dtls)).append("\n");
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

