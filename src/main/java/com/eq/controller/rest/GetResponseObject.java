package java.com.eq.controller.rest;

import java.util.HashMap;
import java.util.List;

/**
 * Generic response object which is used on get requests.
 * Created by Andreas on 16.01.2017.
 */
public class GetResponseObject extends HashMap<String, Object> {

    private final static String META_KEY = "_metadata";
    private final String HIST_OBJ_VRSN_KEY_NAME = "vrsn";

    public GetResponseObject result(String key, List<?> body) {
        this.put(key, body);
        return this;
    }

    public GetResponseObject result(String key, String body) {
        this.put(key, body);
        return this;
    }

    public GetResponseObject metadata(GetResponseObjectMetadata metadata) {
        this.put(META_KEY, metadata);
        return this;
    }

}
