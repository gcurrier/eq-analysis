package java.com.eq.controller.rest;

import java.util.Objects;

/**
 * Metadata used for describing return values of more than one entity.
 */
public class GetResponseObjectMetadata {
    private Integer totalCount = null;

    private Integer limit = null;

    private Integer offset = null;

    public GetResponseObjectMetadata totalCount(Integer totalCount) {
        this.totalCount = totalCount;
        return this;
    }

    /**
     * The total count of entities in the system.
     *
     * @return totalCount
     **/
    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public GetResponseObjectMetadata limit(Integer limit) {
        this.limit = limit;
        return this;
    }

    /**
     * The amount of elements contained in the message.
     *
     * @return limit
     **/
    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public GetResponseObjectMetadata offset(Integer offset) {
        this.offset = offset;
        return this;
    }

    /**
     * The offset from which on the elements are listed.
     *
     * @return offset
     **/
    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        GetResponseObjectMetadata metadata = (GetResponseObjectMetadata) o;
        return Objects.equals(this.totalCount, metadata.totalCount) &&
                Objects.equals(this.limit, metadata.limit) &&
                Objects.equals(this.offset, metadata.offset);
    }

    @Override
    public int hashCode() {
        return Objects.hash(totalCount, limit, offset);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class Metadata {\n");

        sb.append("    totalCount: ").append(toIndentedString(totalCount)).append("\n");
        sb.append("    limit: ").append(toIndentedString(limit)).append("\n");
        sb.append("    offset: ").append(toIndentedString(offset)).append("\n");
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

