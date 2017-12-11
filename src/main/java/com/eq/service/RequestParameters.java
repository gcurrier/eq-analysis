package java.com.eq.service;

import com.eq.domain.core.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * The query request parameters hold information for filtering the result set and returning subsets of a big result set.
 *
 * @author froa
 * @version 2014-09-05
 */
public class RequestParameters {
    /**
     * A list of field names to return.
     */
    public List<String> fields = null;
    /**
     * The zero-based index of the first element to return. Defaults to 0 if not supplied.
     */
    public int offset = 0;
    /**
     * The maximum number of elements to return.
     */
    public int limit = -1;
    /**
     * The string representation of a json array holding objects with the keys and the sort direction.
     */
    public List<SortModel> sort = null;
    /**
     * The string representation of a json object holding filter fields, values and expressions.
     */
    public List<FilterModel> filter = null;

    /**
     * Whether or not to include the object history.
     */
    public Boolean history = false;
    /**
     * A query expression to find matching results for.
     */
    public String q = null;
    /**
     * The offset to use when paging the object history.
     */
    private int histOffset = 0;
    /**
     * The limit to use when paging the offset history.
     */
    private int histLimit = -1;
    /**
     * The string representation of a json array holding objects with the keys and the sort direction for the object history.
     */
    private List<SortModel> histSort = null;
    /**
     * The string representation of a json object holding filter fields, values and expressions for the object history.
     */
    private List<FilterModel> histFilter = null;

    /**
     * Creates a request parameter from the given values.
     *
     * @param fields     A list of field names to return.
     * @param offset     The zero-based index of the first element to return. Defaults to 0 if not supplied.
     * @param limit      The maximum number of elements to return.
     * @param sort       The string representation of a json array holding objects with the keys and the sort direction.
     * @param filter     The string representation of a json object holding filter fields, values and expressions.
     * @param history    Whether or not to include the object history.
     * @param histOffset The offset to use when paging the object history.
     * @param histLimit  The limit to use when paging the offset history.
     * @param histSort   The string representation of a json array holding objects with the keys and the sort direction for the object history.
     * @param histFilter The string representation of a json object holding filter fields, values and expressions for the object history.
     * @param q          A query expression to find matching results for.
     * @return An object on which only the relevant values are set.
     */
    public static RequestParameters create(
            Logger log,
            List<String> fields,
            Integer offset,
            Integer limit,
            String sort,
            String filter,
            Boolean history,
            Integer histOffset,
            Integer histLimit,
            String histSort,
            String histFilter,
            String q) {
        RequestParameters rp = new RequestParameters();
        if (fields != null)
            rp.setFields(new ArrayList<>(fields));
        if (offset != null)
            rp.setOffset(offset);
        if (limit != null) rp.setLimit(limit);
        if (sort != null) rp.setSort(SortModel.parseFromJson(sort, log));
        if (filter != null) rp.setFilter(filter, log);
        if (history != null) rp.setHistory(history);
        if (histOffset != null) rp.setHistOffset(histOffset);
        if (histLimit != null) rp.setHistLimit(histLimit);
        if (histSort != null) rp.setHistSort(SortModel.parseFromJson(histSort, log));
        if (histFilter != null) rp.setHistFilter(histFilter, log);
        if (q != null) rp.setQ(q);
        return rp;
    }

    /**
     * @return
     */
    public List<String> getFields() {
        return fields;
    }

    /**
     * @param fields
     * @return
     */
    public RequestParameters setFields(List<String> fields) {
        this.fields = fields;
        return this;
    }

    /**
     * @return
     */
    public int getOffset() {
        return offset;
    }

    /**
     * @param offset
     * @return
     */
    public RequestParameters setOffset(int offset) {
        this.offset = offset;
        return this;
    }

    /**
     * @return
     */
    public int getLimit() {
        return limit;
    }

    /**
     * @param limit
     * @return
     */
    public RequestParameters setLimit(int limit) {
        this.limit = limit;
        return this;
    }

    /**
     * @return
     */
    public List<SortModel> getSort() {
        return sort;
    }

    /**
     * @param sort
     * @return
     */
    public RequestParameters setSort(List<SortModel> sort) {
        this.sort = sort;
        return this;
    }

    /**
     * @param json
     * @param log
     * @return
     */
    public RequestParameters setSort(String json, Logger log) {
        this.sort = SortModel.parseFromJson(json, log);
        return this;
    }

    /**
     * @return
     */
    public List<FilterModel> getFilter() {
        return filter;
    }

    /**
     * @param filter
     * @return
     */
    public RequestParameters setFilter(List<FilterModel> filter) {
        this.filter = filter;
        return this;
    }

    /**
     * @param json
     * @param log
     * @return
     */
    public RequestParameters setFilter(String json, Logger log) {
        this.filter = parseFilters(json, log);
        return this;
    }

    /**
     * @param json
     * @param log
     * @return
     */
    private List<FilterModel> parseFilters(String json, Logger log) {
        //general build of json is
        //Object.<string,IFilter> with string as the field name and IFilter as one of the possible filters
        //filter is expected to be one of
        //SetFilter -> Array.<string>
        //TextFilter -> {type:string,filter:string}
        //NumberFilter -> {type:string,filter:number,filterTo:number}
        //DateFilter -> {type:string,date:date,dateTo:date}
        List<FilterModel> filters = new ArrayList<>();
        try {
            JSONObject oJsn = new JSONObject(json);
            List<String> keyList = new ArrayList<>(oJsn.keySet());
            for (String aKeyList : keyList) {
                String type = "";
                try {
                    oJsn.getJSONObject(aKeyList);
                    type = "json";
                } catch (Exception ignore) {
                }
                try {
                    oJsn.getJSONArray(aKeyList);
                    type = "arr";
                } catch (Exception ignore) {
                }
                switch (type) {
                    case "arr":
                        JSONArray setArr = oJsn.getJSONArray(aKeyList);
                        List<String> set = new ArrayList<>();
                        for (int j = 0; j < setArr.length(); j++)
                            set.add(setArr.getString(j));
                        filters.add(new SetFilterModel().fieldName(aKeyList).setSet(set));
                        break;
                    case "json":
                        JSONObject oJ = oJsn.getJSONObject(aKeyList);
                        type = "text";
                        if (!oJ.has("type") || oJ.isNull("type"))
                            continue;
                        if (oJ.has("filterTo"))
                            type = "number";
                        else if (oJ.has("date") || oJ.has("dateTo"))
                            type = "date";
                        else if (!oJ.has("filter"))
                            continue;
                        //correct type recognition for numbers - following are only present in the number filter
                        if (type.compareTo("text") == 0)
                            switch (oJ.getString("type")) {
                                case "notEquals":
                                    type = "number";
                                    break;
                                case "lessThanOrEqual":
                                    type = "number";
                                    break;
                                case "greaterThan":
                                    type = "number";
                                    break;
                                case "greaterThanOrEqual":
                                    type = "number";
                                    break;
                                case "inRange":
                                    type = "number";
                                    break;
                            }
                        //create filter model
                        switch (type) {
                            case "text":
                                if (oJ.isNull("filter"))
                                    continue;
                                filters.add(
                                        new TextFilterModel()
                                                .fieldName(aKeyList)
                                                .type(TextFilterModel.TypeEnum.fromValue(oJ.getString("type")))
                                                .filter(oJ.getString("filter"))
                                );
                                break;
                            case "number":
                                if (!oJ.has("filter") || oJ.isNull("filter"))
                                    continue;
                                filters.add(
                                        new NumberFilterModel()
                                                .fieldName(aKeyList)
                                                .type(NumberFilterModel.TypeEnum.fromValue(oJ.getString("type")))
                                                .filter(oJ.getLong("filter"))
                                                .filterTo(oJ.getLong("filterTo"))
                                );
                                break;
                            case "date":
                                if (oJ.isNull("date"))
                                    continue;
                                DateFilterModel dfm = new DateFilterModel();
                                dfm.setFieldName(aKeyList);
                                dfm.setType(DateFilterModel.TypeEnum.fromValue(oJ.getString("type")));
                                dfm.setDate(Instant.ofEpochMilli(oJ.getLong("date")));
                                if (oJ.has("dateTo") && !oJ.isNull("dateTo"))
                                    dfm.setDateTo(Instant.ofEpochMilli(oJ.getLong("dateTo")));
                                filters.add(dfm);
                                break;
                            default:
                                continue;
                        }
                        break;
                }
            }
        } catch (Exception e) {
            log.warn("Unable to create filters from json.", e);
        }
        return filters;
    }

    /**
     * @return
     */
    public Boolean getHistory() {
        return history;
    }

    /**
     * @param history
     * @return
     */
    public RequestParameters setHistory(Boolean history) {
        this.history = history;
        return this;
    }

    /**
     * @return
     */
    public int getHistOffset() {
        return histOffset;
    }

    /**
     * @param histOffset
     * @return
     */
    public RequestParameters setHistOffset(int histOffset) {
        this.histOffset = histOffset;
        return this;
    }

    /**
     * @return
     */
    public int getHistLimit() {
        return histLimit;
    }

    /**
     * @param histLimit
     * @return
     */
    public RequestParameters setHistLimit(int histLimit) {
        this.histLimit = histLimit;
        return this;
    }

    /**
     * @return
     */
    public List<SortModel> getHistSort() {
        return histSort;
    }

    /**
     * @param histSort
     * @return
     */
    public RequestParameters setHistSort(List<SortModel> histSort) {
        this.histSort = histSort;
        return this;
    }

    /**
     * @return
     */
    public List<FilterModel> getHistFilter() {
        return histFilter;
    }

    /**
     * @param histFilter
     * @return
     */
    public RequestParameters setHistFilter(List<FilterModel> histFilter) {
        this.histFilter = histFilter;
        return this;
    }

    /**
     * @param json
     * @param log
     * @return
     */
    public RequestParameters setHistFilter(String json, Logger log) {
        this.histFilter = parseFilters(json, log);
        return this;
    }

    /**
     * @return
     */
    public String getQ() {
        return q;
    }

    /**
     * @param q
     * @return
     */
    public RequestParameters setQ(String q) {
        this.q = q;
        return this;
    }
}
