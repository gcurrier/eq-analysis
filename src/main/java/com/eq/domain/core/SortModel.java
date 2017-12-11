package java.com.eq.domain.core;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * SortModel
 */
public class SortModel {
    //    @JsonProperty("colId")
//    private String colId = null;
//    @JsonProperty("sort")
//    private SortEnum sort = null;
    private String colId;

    private SortDirection sort;

    /**
     * Default constructor.
     */
    public SortModel() {
    }

    public static List<SortModel> parseFromJson(String json, Logger log) {
        List<SortModel> retVal = new ArrayList<>();
        //json is expected to be Array.<{colId:string,sort:'asc'|'desc'}>
        try {
            JSONArray oArr = new JSONArray(json);
            for (int i = 0; i < oArr.length(); i++) {
                JSONObject entry = oArr.getJSONObject(i);
                retVal.add(new SortModel().setColId(entry.getString("colId")).setSort(SortDirection.byName(entry.getString("sort"))));
            }
        } catch (Exception e) {
            log.warn("Could not parse sort model json.", e);
        }
        return retVal;
    }

    public SortModel colId(String colId) {
        this.colId = colId;
        return this;
    }

    //    /**
//     * The name of the field to apply sorting on.
//     *
//     * @return colId
//     **/
//    @JsonProperty("colId")
//    public String getColId() {
//        return colId;
//    }
//
//    public void setColId(String colId) {
//        this.colId = colId;
//    }
//
//    public SortModel sort(SortEnum sort) {
//        this.sort = sort;
//        return this;
//    }
//
//    /**
//     * The sort direction. One of &#39;asc&#39;, &#39;desc&#39;.
//     *
//     * @return sort
//     **/
//    @JsonProperty("sort")
//    public SortEnum getSort() {
//        return sort;
//    }
//
//    public void setSort(SortEnum sort) {
//        this.sort = sort;
//    }
//
//    /**
//     * The sort direction. One of &#39;asc&#39;, &#39;desc&#39;.
//     */
//    public enum SortEnum {
//        ASC("asc"),
//
//        DESC("desc");
//
//        private String value;
//
//        SortEnum(String value) {
//            this.value = value;
//        }
//
//        @JsonCreator
//        public static SortEnum fromValue(String text) {
//            for (SortEnum b : SortEnum.values()) {
//                if (String.valueOf(b.value).equals(text)) {
//                    return b;
//                }
//            }
//            return null;
//        }
//
//        @Override
//        @JsonValue
//        public String toString() {
//            return String.valueOf(value);
//        }
//    }
    public String getColId() {
        return colId;
    }

    public SortModel setColId(String colId) {
        this.colId = colId;
        return this;
    }

    public SortDirection getSort() {
        return sort;
    }

    public SortModel setSort(SortDirection sort) {
        this.sort = sort;
        return this;
    }

    public enum SortDirection {
        ASC("asc"),
        DESC("desc");

        public final String name;

        SortDirection(String name) {
            this.name = name;
        }

        static SortDirection byName(String name) {
            for (SortDirection x : SortDirection.values())
                if (x.name.compareTo(name) == 0)
                    return x;
            return null;
        }
    }
}

